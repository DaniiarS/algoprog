import label from "../../lib/label"
import level from "../../lib/level"
import problem from "../../lib/problem"
import topic from "../../lib/topic"

topic_20059 = () ->
    return topic("2016, 2 тур", "2016, 2 тур", [
        problem(113221),
        problem(113222),
        problem(113223),
        problem(113224),
    ])

topic_20058 = () ->
    return topic("2016, 1 тур", "2016, 1 тур", [
        problem(113217),
        problem(113218),
        problem(113219),
        problem(113220),
    ])

export default level_roi2016 = () ->
    return level("roi2016", "2016", [
        label("<h2>2016</h2>"),
        topic_20058(),
        topic_20059(),
    ])