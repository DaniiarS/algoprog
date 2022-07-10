import contest from "../../lib/contest"
import label from "../../lib/label"
import link from "../../lib/link"
import page from "../../lib/page"
import problem from "../../lib/problem"
import topic from "../../lib/topic"
import {ruen} from "../../lib/util"

mainPrinciples = () ->
    page("Главные правила работы с геометрией", String.raw"""
        <h1>Главные правила работы с геометрией</h1>
        <p>
        При работе с геометрией есть три главных правила. (Этот текст — в дополнение в основной теории в видеолекциях.)
        </p>
        <p>Во-первых, помните правила работы с вещественными числами, и главное — <b>не используйте вещественные числа, если можно обойтись без них</b>. 
        Если все входные данные у вас целочисленны (а так обычно бывает), то нередко можно все задачу полностью решить в целых числах. 
        И это намного правильнее, чем использовать вещественные числа. Иногда, конечно, бывает так, что в целых числах задачу не решить,
        например, если ответ сам по себе может быть вещественным (например, если надо найти точку пересечения двух прямых, то ее координаты могут быть нецелыми,
        даже если входные данные целочисленны).
        Но тогда постарайтесь в любом случае использовать вещественные числа только там, где они потребовались — например, прежде чем искать точку пересечения
        вы, наверное, заходите проверить, не параллельны ли две прямые, а это можно и нужно делать полностью в целых числах.
        А если уж вам приходится использовать вещественные числа, то не забывайте про <code>eps</code>.</p>

        <p>Во-вторых, <b>ваши друзья — это векторное и скалярное произведение</b>. Почти все задачи про прямые, отрезки, точки и т.д. можно решить с помощью векторных 
        и скалярных произведений, и такое решение будет работать чище и надежнее, чем любое другое. Если вы работаете с прямыми, то можете использовать представление прямой
        в виде коэффициентов A, B, C — это по сути то же векторное или скалярное произведение, только вид сбоку.</p>

        <p>В-третьих, <b>старайтесь не работать отдельно с координатами X и Y</b>. Если вы хотите рассмотреть особо случай типа <code>x==0</code>,
        или вообще вы хотите написать формулу, в которую входит только <code>x</code>, и т.п. — скорее всего, 
        вы что-то делаете не так. Скорее вам надо использовать векторное или скалярное произведение (см. правило 2), и <code>x==0</code> не будет особым случаем.
        Вообще, большинство из тех задач, которые будут в этой теме, обладают вращательной симметрией — если вы повернете всю картину на произвольный угол вокруг начала координат,
        то задача останется такой же, ответ или не изменится, или тоже повернется. Поэтому логично и в коде использовать только те величины, которые не меняются при повороте.
        Вот скалярное и векторное произведения — не меняются. А отдельные координаты — меняются. Если вы пишете условие <code>if x == 0</code>, то при повороте результат сравнения изменится.
        А если вы считаете векторное произведение и сравниваете его с нулем — результат сравнения не изменится. Намного удобнее писать код так, чтобы он не зависел от поворота.
        (Конечно, если по смыслу задачи вращательной симметрии нет, то основные аргументы тут уже не работают, и вам где-то придется писать несимметричный код, но во многих задачах симметрия есть.)

        <p>Частным случаем п. 3 является то, что не надо использовать представление прямой в виде <code>y=k*x+b</code>. 
        Мало того, что оно не симметрично относительно X и Y, оно еще и не работает для вертикальных прямых. 
        Используйте представление в виде <code>A*x+B*y+C=0</code>,
        или через векторное произведение (что на самом деле то же самое, что и ABC), или параметрический способ.</p>
    """, {skipTree: true})

export default geometry_simple = () ->
    return {
        topic: topic(
            ruen("Простая геометрия", "Simple geometry"),
            ruen("Задачи на простую геометрию", "Problems on simple geometry"),
        [label("<div>См. <a href=\"https://sis.khashaev.ru/2013/july/b-prime/\">видеозаписи лекций ЛКШ.2013.B'</a>, раздел \"Вычислительная геометрия\".<br>\nСм. <a href=\"https://sis.khashaev.ru/2008/august/b-prime/\">видеозаписи лекций ЛКШ.2008.B'</a>, раздел \"Вычислительная геометрия\".</div>"),
            mainPrinciples(),
            problem(269),
            problem(275),
            problem(436),
            problem(447),
            problem(448),
            problem(1353),
            problem(279),
            problem(280),
            problem(433),
        ], "geometry_simple"),
        advancedProblems: [
            problem(1350),
            problem(435),
            problem(2806),
            problem(1349),
            problem(3870),
            problem(493),
            problem(441),
            problem(3099),
        ]
    }
