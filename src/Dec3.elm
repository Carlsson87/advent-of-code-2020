module Dec3 exposing (one, theMap, two)

import List.Extra as List


type alias Map =
    List (List Char)


type alias Coordinates =
    ( Int, Int )


one : Int
one =
    travel (move 1 3)


two : Int
two =
    List.product
        [ travel (move 1 1)
        , travel (move 1 3)
        , travel (move 1 5)
        , travel (move 1 7)
        , travel (move 2 1)
        ]


move : Int -> Int -> Coordinates -> Coordinates
move x y =
    Tuple.mapBoth ((+) x) ((+) y)


get : Map -> Coordinates -> Maybe Char
get map ( x, y ) =
    List.getAt x map
        |> Maybe.andThen (List.getAt (remainderBy 31 y))


travel : (Coordinates -> Coordinates) -> Int
travel step =
    let
        start =
            ( 0, 0 )
    in
    theMap
        |> List.foldl (\_ ( cs, c ) -> ( step c :: cs, step c )) ( [ start ], start )
        |> Tuple.first
        |> List.reverse
        |> List.filterMap (get theMap)
        |> List.count ((==) '#')


theMap : Map
theMap =
    List.map String.toList <|
        String.lines <|
            """...............#...#..#...#....
...#....##.....##...######..#..
....#.....#.##..#...#..#.......
...#..........#.#....#......#..
....#.#...#.#.......#......##.#
....#.#..........#.....#.##....
##...#.#.##......#......#.#.#..
#.#.#........#....#..#.#.......
..#...##..#..#.......#....###..
.#.#..........#...#........#..#
.#..#......#....#.#...#...#.#.#
..#.........#..##.....#.#.##.#.
.#......#...#....#.....#......#
........#..##..##.........#..#.
.....#....###..#....##........#
.###...#..##..#.##......##...##
.#...#...#..#.#..#...##.....#..
.......#....#....#.#...#.......
.##.......#.##...#.#...#..#....
#.#...#......#....#.......#....
..###...............####...#.#.
.##.#....#......#..#...#.#..#.#
.............#.#.#......##.....
#....#.#.#........#....##...#..
...##....##...##..#...#........
..##......#...#......#...###...
...#...##......##.#.#..#.......
#......#..#...#.#..#......#..##
.#..#..#........##....##.......
.#...........###.###.##...#....
............#.#...........#.#..
#...#........#...#...#..#.#.#.#
...#.......#.#.#..#.#..........
......#..#..#....##..##..##....
........##...#......#..#.#.....
..#.#.......#......#...........
#.#.....#......##..........#.#.
#.....###.#...#...#..#....#...#
.##.#...#............##.....#..
###....#.#.....#.......##......
##.......##.....#..#...#..##.##
....#.##............###...#..##
.###..#...##.#..#..##..#.......
.##.##..####.....#.........#...
....####..#...#....#.#...#.....
..##....#..#......#...........#
..........#......#..##.......#.
.................#.#.#........#
#.......##.#...##.......##.##..
.#................#.#.....##..#
......#..#............##.#.....
...##............#.....#.....#.
##.###.#.......#....#.........#
......#.....#.#.#.#......#.....
......#.##......#......##......
..#....#...#..#.....#..#....#.#
.#.##.##.....#.......#.......#.
...#..#.#......##....##..#.....
.#.....#......##...#..#.#....#.
..#......#....#..#..###.#.#....
.....#........#.#...#..#.#.....
....#.#.......#...##.....####..
#..#..##...#...........#...#..#
.#..#...#.....#.....#.#.....#.#
..##..###.....#...#.#.#.......#
#..##.##......###..#......###..
#..#...#.......#....#.#...#.#.#
...........###..#...#..##....#.
.....#...........###.......#...
##......#.......#......##.#..#.
#.................#........#...
#.#.............#......#...#..#
......#.#....#....#....#....#.#
..#...#....#..#....#....#..#...
#....#......#..#...#..#....#.#.
..#.....#..#...#...#.......#...
.#........###..##.#..#.........
.....##.#.....#..###..#........
...#...#.###....######......#..
.###.#..#.....#.....#..#...#...
##..#.#......#.........#...#..#
###...##..###.......#..##.#.#.#
.#...................#..#...##.
.#...#...###...#.......#......#
....#.....##....#...##.#...#.##
..#....#......#...#..###.......
.........#..........##........#
...#.........##..#....#..###...
......#.##....#.#........#.#.##
....#..#...#.............#....#
#..#.....#.#.....#....#........
....#..#...####.#.###..#.......
.....#....#....#..#..#.#.....#.
#..##....#.....#.#.............
.##...#..#.......#...##.###....
##......#...##....#......##....
#......#.#......#.#..#......#..
.#...#......#............###..#
.#..#.#.....#.#.....#..#....#..
.#............#...#..#..#...##.
...#...#....#.#.#....#....#....
........#......###.#....##.##.#
......#.#..................##..
..#..#........#..##..........##
.#...#.#....#####.#.#..#.......
.....#..#.#..#.....#.#........#
#.#..#..#.#..........#..#..#...
.##........#.#.......#........#
.....#....#..##...#......##....
....#.##.##...##.#.........#.#.
...#...#..#.#.......#.......#..
.................##..#.........
..##.##....#...#.##.......#..#.
....#...........#.....###....##
.#..................#..........
....#.##....#......##.#..#.##.#
#......#..#.#....##...####...#.
#.....#.#.##...........#.##...#
.......#...##..#.........##....
.#...#..........##......#..#.#.
#...#.#......#.....#........#..
........#.....#.......##......#
.#..#...........#...#..#..#....
......#.##......##.#......#..##
......#....#..#................
##.#.......#......#..#....##.##
..#...###..#.......#...#.#....#
.....#...#.........#.....#..#.#
..#.....#.........#..#...#.#...
.#.........##..#.#...#.....##..
..........#.#.#...#....#....#..
....#.###.#..#..#..#.#........#
..#...##...##.#.#.....#.#..##..
.#..#......#.####..#.......#..#
##.......#.....#.#.#..#...##..#
.##......##...##.........#..#..
..#.##..#......#......#..#..#..
..#..#.##..#........#....#.#...
##.####...##.#..##.........#..#
.#.......#.#..#.....#.##.......
........#.........#...........#
..#...#.####.....##.##.#....#.#
.....#..##.#..###.##.#.#...#...
#..##..##....#...#....#...#....
.###.#....#..#.......#......###
.#....##.....#.#........#...#.#
#.#.#..#..#...#....#..#.....#..
....##...#.##..#............#..
##......###...#...#...#....#...
#.#...#.#..#..##.##..##..#....#
.#...#.#....#..##.#..##..#.....
.............#..#..#.#.....#...
#........#..........#....###...
..#..#......#...#........#.....
.#..#.............#.........#..
#.....#....##..#..#.#.#..#.....
...#......#.........#.#....##.#
..#.......##....###..#.........
.#.......#......#..............
.#...##.....##...###.#....#.#..
......#....#.........#.......#.
##.......#..##....###.#.....##.
.....#......####.....#......#..
....#....#..###....#.....##...#
...#...#.#........#.....#..#.##
#..#....#.#...###...##.....##..
#.....##...#.#............#....
##....#.......#.#.#....#.#.###.
#........#...#...####.#....#.#.
.##.#......#........#..#.....#.
...##.#.......#...#.#.##..#...#
......#.........##..#....#.....
.#......#...........#......#...
......#.#.#.#..#.#....#....#..#
##.................##...#.#....
........#.........#..#..#...###
.#........#........#....#..#...
....###.##.##......#.#...#....#
#......#.#..............#......
.......#..#....#..##.........#.
#............#....#............
#...#.#.........##..###...##...
.#....#.#.#.....#..#..##.......
.............##.#.#.......#..#.
#...#..##.#..###.....##..#.....
...#.#.....#...#......##.#..#..
#..........#.##.#...#...#.#...#
...#.#...#.........#.#..#.#..#.
#....#.................#.......
..#..#.#.#..#.#..##...#.#......
..#....#.#.#...#.....#...#.....
#...#.###......#.......#..#..#.
#.#.##.##..............#.#.#..#
#..........#.#.........#.###...
...........#.......#.#..#......
....#.#..#....#....#....##.....
#..#...##########.........#.#..
..#.............##........#.#..
#.#.##......#...#.#....##..##..
..##..#.#.#....#......#.#..#.#.
.#.#...#................#......
#...#...#.....##.#...#.......#.
.....##.......#...#......#.##..
....#.##..........#.#.##....##.
...........##........#.#.#.#...
..#...........###.#....#..#....
..#.#...#...#.#........#.....#.
.##......##.....#........#.....
....#.......#....#...#.##...#..
.#.....##.....#...##...........
#....#.##.##...#...###.#####...
..#.#......#.#.......#....#..#.
..........#...#...........#....
.........#..#...#...#......#.##
.#...#.#...#.###.##..#........#
#....#.....#.......##....#.....
#.....#..#.....#...##.......#..
#.#.#.#.............#.....#...#
...#.....#.....#...............
..##.###.#.#........#.........#
...##..#.##..#....#.#...#.#....
...##...#...##.#.........#.#..#
.###......#....#.........#.#...
###.#.#...#.......#...#.....#.#
...#.#.......#.....####........
......#..#.....###.#....#..#...
..####...#...#..#......#...#...
#..............##....#......##.
..##..###...##..#.#.........#..
#..#.#...#.......#.........##..
..##....#......#...#..##.......
..#.#..#..###.....#.....#...###
.#..#.##.....##.#.#.#........#.
..#.#.........#................
..#...........#.#...##.#...#..#
.....#........#..#.....#....#..
#.#....#...........##.....#..##
##.......#.....#.....#.#......#
.##............####.#........##
....##.#.....#......#....#...#.
.#.#...##.#..##..#..........#..
..........................#....
##..##..#..#.#....#.....#......
...#.#........#.#.##.#.....#..#
#..#....#...#..#...#........#.#
#.......#####...#..#..#.#......
#.##....#......#......#..###...
..#.......#...........#.....##.
#...#....#..#......##...#......
...##.#..##........#..###......
##.#...........#.............##
#.....#..#.....#.....#.........
.#..........#..#......###......
...#...#..##.......#...#...#.#.
..####......#.....#..#.#......#
....#..#.....#.#...............
.#.......#....#.....#..##....#.
.....#.........#..........##...
#...........#..#.....#........#
............#..##...#...#.#....
##.............####...#.....#..
.....#......#....##.#.....##...
...........#.....#.#..#.#......
.#.#......#....#.............##
##...#.#.......##........#.....
#..#.....#.#.......####...#..#.
....#.#...#....#.###..#..#.#...
.....#.#..#......#.##.#####.#..
.....#....##..........#......#.
#.......#........##.......##...
#...#..#..##.#....#...#...#....
...#..##..#...#..........#.....
#..#....###.....#......##......
...###......#.....#....#.......
#.#...#.#..###.####.......#.#.#
...#......#.#..##..#.....#.....
#.#............#.....##.#......
#..#......##...##..#...#.#..###
#.....#...#..#..#....#..###....
####..###....#..##....#..#.....
..##.#.....#.......##....#.#.#.
##..#.#.......#.#...##.#..#.#..
..#.#.#.##.#.#.#...........#...
...#.##.....#....#..#.#..#.....
...#..#.........#..........#..#
#...#..#.....#.#.#.............
##.#....##.##...#...#..#..#..#.
....####..##..##.#..#...##.....
##.....##.#.#...#.#.......###..
#..#.#....#......#.......##...#
#.#...............#..#..#......
.....##...##..#........#......#
.#..#............##......#....#
......#.#..#..##.#......#.....#
..#.#.............#...#......##
....#.#..#..#...##...#..##.....
#.#.............#...#.#..#....#
#..#..#.##....#....#...#.......
....#..#..........#.....##...#.
..#####.......#...#..........#.
....#......##.......#..##.#.#.#
#...#.#.....#....#....##.......
..##.#.#..#.#...#.....##.....#.
#.#..#....#............#..#.#..
...#.##..##..#.#...###......#.#
......##.......#....#......###.
....#..##.......#..#.#....#..#.
#............#..........##..#.#
..#.....#..#.#..##..#....##.#..
.....#.....#....##.#.#......#.#
...####.......###..#...#.#....#
.#.##.....##.....##..#..#......
...#..###..##..................
##..##.....#.#..#..#.#........#
.#.#........##.........#....#..
........#......###....#...#....
......#...........#...........#
.#...###...#.........#.#...#..#
.....#..........#......##....#.
.#.#...#........##.......#.#...
.....##.....##....#...#...#..#.
..#.....................##...##
#..#.#......##...##..#......#.."""
