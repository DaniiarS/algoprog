import contest from "../../lib/contest"
import label from "../../lib/label"
import link from "../../lib/link"
import page from "../../lib/page"
import problem from "../../lib/problem"
import topic from "../../lib/topic"
import {ruen} from "../../lib/util"

module16344 = () ->
    page("Краткая теория про два указателя", String.raw"""
        <div class="box generalbox generalboxcontent boxaligncenter clearfix"><h1>Краткая теория про два указателя</h1>
        <p>К сожалению, я не нашел толкового описания метода двух указателей, поэтому напишу свой краткий текст.</p>
        <h2>Пример</h2>
        <p>Два указателя — это довольно простая идея, которая нередко встречается в задачах. Давайте сначала рассмотрим пример.</p>
        <p>Итак, пусть у нас задача: дан массив из $N$ положительных чисел, надо найти в нем несколько чисел, идущих подряд, так, чтобы их сумма была больше $K$, а чисел в нем содержалось бы как можно меньше.</p>
        <p>Первая, довольно понятная идея: пусть мы зафиксировали позицию (номер в массиве) $i$ первого из искомых чисел. Тогда нам надо найти ближайшую к нему справа позицию $j$ такую, что сумма чисел на позициях с $i$ по $j$ больше $K$. Это можно сделать достаточно просто циклом по $j$ от $i$ до $N$, тогда алгоритм решения всей задачи (с учетом перебора $i$) получается следующим:
        </p><pre>for i:=1 to n do begin
            s:=0;
            for j:=i to n do begin
                s:=s+a[j]; // в переменной s подсчитываем текущую сумму
                if s&gt;k then begin
                    // writeln(j); // этот вывод пригодится дальше
                    if j-i+1&lt;min then min:=j-i+1;
                    break;
                end;
            end;
        end;
        </pre>
        <p>Он работает за $O(N^2)$. Придумаем, как его можно ускорить до $O(N)$.</p>
        <p>Ключевая идея здесь следующая: если при каком-то $i=i_0$ мы в цикле по $j$ дошли до некоторого значения $j=j_0$, то при следующем $i=i_0+1$ найденное значение $j$ будет обязательно <i>не меньше</i> $j_0$. Говоря по-другому, если мы раскомментируем <code>writeln</code> в приведенном выше коде, то выводимые значения $j$ образуют неубывающую последовательность.</p>
        <p>Действительно, если при некотором $i=i_0$ мы пропустили все $j$ до $j_0$, то это значит, что сумма чисел начиная от $i_0$ до всех промежуточных $j$ была $\leq K$. Но тогда если мы начнем считать сумму чисел начиная с позиции $i_0+1$, то для всех тех же промежуточных $j$ сумма чисел уж точно будет $\leq K$ (т.к. по условию все числа положительны).</p>
        <p>А это обозначает, что нам не надо каждый раз заново запускать поиск $j$ начиная от $i$! Мы можем каждый раз начинать поиск $j$ с того значения, на котором остановились в прошлый раз:</p>
        <pre>s:=0;
        for i:=1 to n do begin
            for j:=j to n do begin // цикл начинается с j!
                s:=s+a[j]; 
                if s&gt;k then begin
                    if j-i+1&lt;min then min:=j-i+1;
                    s:=s-a[j]; // это грубый костыль, потому что на следующей итерации
                               // мы будем делать опять s:=s+a[j] с тем же j.
                               // ниже будет видно, как это сделать красивее.
                    break;
                end;
            end;
            s:=s-a[i]; // чтобы не вычислять s каждый раз заново
        end;
        </pre>
        Этот же код можно переписать несколько по-другому, может быть, проще:
        <pre>j:=1;
        s:=0;
        for i:=1 to n do begin
            while (j&lt;n)and(s&lt;=k) do begin // мы таким образом начинаем со старого значения j
                s:=s+a[j];
                inc(j);
            end;
            if s&gt;k then begin
                // +1 пропало, потому что теперь j указывает на первый невзятый элемент.
                if j-i&lt;min then min:=j-i;
            end else // если мы попали сюда, то j=n, но s&lt;=k - дальше искать нечего
                break;
            s:=s-a[i]; // перед началом следующей итерации выкинем число i
        end;
        </pre>
        <p>Это решение работает за $O(N)$. Действительно, обе переменных цикла — и $i$, и $j$ — все время работы программы <i>только увеличиваются</i>. Общее количество итераций внутреннего цикла будет равно общему количеству увеличений $j$, а это равно $N$. Все, кроме внутреннего цикла, тоже работает за $O(N)$, получаем и общую сложность $O(N)$.</p><p>
        </p><p>Переменные $i$ и $j$ в даннном контексте часто называют <i>указателями</i> — конечно, не в том смысле, что они имеют тип <code>pointer</code> (что неверно), а просто в том смысле, что они указывают на определенные позиции в массиве. Поэтому и метод этот называется методом двух указателей.</p>
        <h2>Общая идея</h2>
        <p>На этом примере очень хорошо видна суть метода двух указателей: мы пользуемся тем, что при увеличении значения одного указателя значение другого указателя тоже может только увеличиваться. Если мы перебираем $i$ в порядке возрастания, то $j$ тоже будет только возрастать — поэтому не надо перебирать каждый раз заново, можно просто продолжать с предыдущего значения.</p>
        <p>Конечно, это так не в каждой задаче, но есть задачи, где это можно доказать и это работает.</p>
        
        <h2>Еще примеры:</h2>
        <ul>
        <li>На прямой находятся $N$ точек; требуется подсчитать количество пар точек, расстояние между которыми $\geq D$. Решение: сортируем точки по координате (если они не отсортированы во входных данных). Идем одним указателем $i$ от 1 до $N$, второй указатель $j$ меняем так, чтобы среди точек, лежащих "правее" $i$ (т.е. с бОльшими номерами) он указывал на самую "левую" точку такую, что расстояние от точки $i$ до точки $j$ было $\geq D$. На каждом шагу добавляем к ответу $N-j+1$ — это общее количество точек, лежащих правее $i$ на расстоянии как минимум $D$ от нее. Поскольку при увеличении $i$ значение $j$ тоже может только увеличиваться, то метод двух указателей сработает.</li>
        <li>Даны два отсортированных массива, надо проверить, есть ли среди них одинаковые числа. Решение: запускаем два указателя, первый ($i$) бежит по одном массиву ($a$), второй ($j$) по другому ($b$) так, чтобы $b[j]$ всегда было первым элементом, большим или равным $a[i]$.</li>
        <li>На окружности заданы $N$ точек, надо найти пару точек, расстояние между которыми (по хорде окружности) максимально. Решение: сортируем точки так, чтобы они шли в порядке обхода окружности, пусть против часовой стрелки. Берем первую точку ($i=1$) и находим максимально удаленнную от нее, пусть это будет точка $j$. Далее переходим к следующей точке против часовой стрелки ($i=2$). Несложно видеть, что самая удаленная от нее точка тоже сдвинется против часовой стрелки (ну или останется на месте), т.е. $j$ только увеличится. И так далее; надо только учесть, что окружность зациклена и после $N$-й точки идет первая. В итоге в решении оба указателя совершат полный оборот по окружности.</li>
        <li>На окружности заданы $N$ точек, надо найти три точки такие, что площадь натянутого на них треугольника максимальна. Решение за $O(N^2$): сортируем точки так же. Зафиксируем первую вершину треугольника. Запустим два указателя для второй и третьей вершин треугольника: при сдвиге второй вершины треугольника против часовой стрелки третья тоже двигается против часовой стрелки. Так за $O(N)$ найдем треугольник максимальной площади при фиксированной первой вершине. Перебрав все первые вершины, за $O(N^2)$ решим задачу.</li>
        </ul>
        
        <h2>Альтернативные реализации</h2>
        <p>Выше у нас всегда один указатель был "главным", а другой "ведомым". Нередко программу можно написать и так, что оба указателя будут равноправными. Ключевая идея — на каждом шагу смотрим на текущую "ситуацию" и в зависимости от нее двигаем один из двух указателей.</p>
        <p>Например, в нашем примере про сумму на подотрезке больше $K$:</p>
        <pre>i:=1;
        j:=1;
        s:=a[1];
        while j&lt;=n do begin
            if s&gt;k then begin
                        // если s&gt;k, то надо, во-первых, проверить решение,
                        // а во-вторых, точно можно двигать первый указатель
                if j-i+1&lt;min then min:=j-i+1;
                s:=s-a[i]; // не забываем корректировать сумму
                inc(i);
            end else begin // а иначе надо двигать второй указатель
                inc(j);
                s:=s+a[j];
            end;
        end;
        </pre>
        <p>Еще проще — в задаче поиска двух одинаковых элементов в двух отсортированных массивах (считаем, что массивы отсортированы по возрастанию):</p>
        <pre>while (i&lt;=n)and(j&lt;=m) do begin
            if a[i]=b[j] then begin
                writeln(i,' ',j);
                break;
            end else if a[i]&gt;b[j] then inc(j)
            else inc(i);
        end;
        </pre>
        
        <h2>Два указателя и бинпоиск</h2>
        <p>Многие задачи, решаемые двумя указателями, можно решить и бинпоиском ценой дополнительного $\log N$ в сложности решения. Например, в нашем основном примере можно было бы не двигать второй указатель, а каждый раз его находить заново бинпоиском — правда, пришлось бы заранее посчитать префиксные суммы (т.е. для каждого $k$ вычислить $s[k]$ — сумму первых $k$ элементов массива); после этого сумма на отрезке от $i$ до $j$ вычисляется как разность $s[j]-s[i-1]$.</p>
        <p>Аналогично, в задаче поиска двух одинаковых элементов в двух массивах тоже можно написать бинпоиск для поиска нужного $j$.</p>
        <p>Но задачу про две наиболее удаленные точки на окружности бинпоиском не очень решишь (хотя можно там сделать тернарный поиск).</p>
        
        <h2>Два указателя и сортировка событий или сканлайн</h2>
        <p>В дальнейшем вы узнаете про метод сортировки событий, он же сканлайн. Сейчас я пока только скажу, что он имеет много общего с методом двух указателей. А именно, многие задачи на два указателя также решаются и сортировкой событий, или сканлайном. Например, в задаче поиска количества точек на прямой таких, что расстояние между ними $\geq d$, можно было бы взять все данные нам точки, добавить еще раз эти же точки, но сдвинутые вправо на $d$, отсортировать все в одном массиве, сохраняя тип точки (сдвинутая или нет) и потом один раз пробежаться по этому массиву.</p>
        <p>Аналогично, задачу про поиск двух одинаковых чисел в двух массивах можно решить просто слиянием этих двух массивов в один, что тоже можно рассматривать как вариант сканлайна или сортировки событий.</p>
        
        <h2>Много указателей</h2>
        <p>Бывают задачи, когда вам нужны много указателей. Если вы можете организовать алгоритм так, что все ваши $M$ указателей только увеличивают свои значения, то алгоритм будет работать за $O(NM)$. Как-то примерно так:</p>
        <pre>while все указатели не дошли до конца do begin
           if можно увеличить первый указатель then увеличить первый указатель
           else if можно увеличить второй указатель then увеличить второй указатель
           else ...
        end;
        </pre>
        </div>
    """, {skipTree: true})

export default two_pointers = () ->
    return {
        topic: topic(
            ruen("Два указателя", "Two pointers"),
            ruen("Задачи на два указателя", "Problems on two pointers"),
        [module16344(),
            problem(2827),
            problem(111975),
            problem({testSystem: "codeforces", contest: "1354", problem: "B"}),
        ], "two_pointers"),
        advancedProblems: [
            problem(111493),
            problem(111634),
            problem(581),
            problem(3878),
            problem(994),
            problem(2817),
        ]
    }
