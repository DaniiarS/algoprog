import contest from "../../lib/contest"
import label from "../../lib/label"
import link from "../../lib/link"
import page from "../../lib/page"
import problem from "../../lib/problem"
import topic from "../../lib/topic"
import {ruen} from "../../lib/util"

export default tertiary_search = () ->
    return {
        topic: topic(
            ruen("Тернарный (троичный) поиск", "Ternary (ternary) search"),
            ruen("Задачи на тернарный поиск", "Problems on ternary search"),
        [label("См. <a href=\"https://sis.khashaev.ru/2013/july/b-prime/t8O8TB6m_d8/\">видеозаписи лекций ЛКШ.2013.B', раздел \"тернарный поиск\"</a>"),
            problem(3398),
            problem(3859),
            problem({testSystem: "codeforces", contest: "1288", problem: "A"}),
            problem({testSystem: "codeforces", contest: "782", problem: "B"}),
        ], "tertiary_search"),
        advancedProblems: [
            problem(1116),
            problem({testSystem: "codeforces", contest: "1354", problem: "C1"}),
        ]
    }
