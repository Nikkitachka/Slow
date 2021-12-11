//
//  articleList.swift
//  Slow
//
//  Created by Игорь Багдасарян on 11.12.2021.
//
import UIKit
import Foundation
let articlesList = [("bbc.com","Так сколько же воды надо выпивать ежедневно и зачем",UIImage(named: "bbc"), "https://www.bbc.com/russian/vert-fut-47880538","Вы часто слышите этот совет: пейте больше воды. И когда устали, и когда кожа слишком сухая… Но совету этому - очень много лет. Есть ли у него научные основания? В начале XIX века воду давали тем, кто был при смерти. Как писал отец гидропатии (водолечения) Винценц Присниц, только тому, кто находился на грани полного истощения, давали утолить жажду."),
                ("aquaflot.ru", "Что влияет на вкус воды", UIImage(named: "aquaflot"), "https://aquaflot.ru/articles/638/", "Вода, как известно, может обладать определенными вкусовыми качествами. Одна водичка горчит, другая имеет неприятный привкус железа, а третья кажется соленой. Исследователи доказали, что на вкусовые качества воды влияет целый ряд факторов. Во-первых, вкус воды напрямую зависит от ее минерального состава. Во-вторых, вкусовые качества воды находятся в прямой зависимости от содержащихся в воде органических веществ. В частности, вкус той или иной воды определяется интенсивностью разложения этих веществ в воде."),
                ("kingswater.ru", "Можно ли пить воду на ночь", UIImage(named: "kingswater"), "https://kingswater.ru/aboutwater/mozhno-li-pit-vodu-na-noch//", "Вода – незаменимая вещь в жизни человека. Существует определенная норма выпитой жидкости в день. Многие, забывая об этом на протяжении дня, пытаются восполнить водный баланс перед сном. Уметь правильно пить воду тоже нужно. Чрезмерное употребление жидкости на ночь имеет последствия. Но и польза от выпитого стакана перед отходом в кровать присутствует. Так можно ли пить воду перед сном ночью? Для того чтобы принять решение – следует изучить пользу и вред."),
                ("otri-nn.ru", "Что будет если 30 дней пить чистую воду", UIImage(named: "otri-nn"), "https://otri-nn.ru/about-water/article/30-day-water-drink/", "Человеческое тело – клетки, ткани и органы – нуждается в воде, которая поддерживает его жизнедеятельность. Одновременно с этим вода запускает своеобразную оздоровительную терапию, которая стимулирует биохимические процессы, оказывающие существенное влияние на состояние всех систем человека. На первый взгляд, в течение 30 дней сложно пить одну лишь чистую воду. Но, как утверждают специалисты, такая практика прекрасно переносится людьми и может привести к удивительным результатам."),
                ("ria.ru", "Вода без вреда: все о пользе для организма женщин, мужчин и детей", UIImage(named: "ria"), "https://ria.ru/20210303/voda-1599802475.html", "Вода необходима для правильной работы организма человека. Когда она приносит пользу, а когда вред, сколько ее можно пить в день, как ее правильно употреблять, а также как пить воду, чтобы похудеть — в материале РИА Новости"),
                ("who.int", "Питьевая вода", UIImage(named: "whoint"), "https://www.who.int/ru/news-room/fact-sheets/detail/drinking-water", "Основные факты. В 2017 г. 71% мирового населения (5,3 миллиарда человек) пользовались услугами питьевого водоснабжения, организованного с соблюдением требований безопасности, то есть предоставляемого по месту жительства, доступного по мере необходимости и свободного от загрязнений. 90% населения мира (6,8 миллиарда человек) пользовались как минимум базовыми услугами. Под базовой услугой понимается наличие неулучшенного источника питьевой воды, получение воды из которого занимает не более 30 минут."),
                ("ru.wikipedia.org","Вода", UIImage(named: "Wiki"), "https://ru.wikipedia.org/wiki/%D0%92%D0%BE%D0%B4%D0%B0", "Вода́ (оксид водорода, гидроксид водорода) — бинарное неорганическое соединение с химической формулой H2O: молекула воды состоит из двух атомов водорода и одного — кислорода, которые соединены между собой ковалентной связью. При нормальных условиях представляет собой прозрачную жидкость, не имеющую цвета (при малой толщине слоя), запаха и вкуса. В твёрдом состоянии называется льдом (кристаллы льда могут образовывать снег или иней), а в газообразном — водяным паром. Вода также может существовать в виде жидких кристаллов (на гидрофильных поверхностях)."),
                ("healthwaters.ru", "Советы по употреблению воды", UIImage(named: "healthwaters"), "https://www.healthwaters.ru/articles/sovety-po-upotrebleniyu-vody/", "С давних времен наши предки считали, что болезни появляются из-за нехватки чистой питьевой воды. Оказалось, что это отчасти верно: при недостатке воды иммунитет нашего организма ослабляется, и мы легче подхватывает болезни."),
                ("hydrotech-group.com", "8 важных фактов о питьевой воде о которых мы должны постоянно помнить", UIImage(named: "hydrotech"), "https://www.hydrotech-group.com/ru/blog/8-dolezitych-faktov-o-pitnej-vode-ktore-by-si-mal-uvedomit-kazdy-z-nas", "Знаете ли вы, что на один смыв требуется в среднем 8 литров питьевой воды? Весьма поразительно, что, в то время как  мы тратим нашу воду таким образом, почти 800 миллионов человек на Земле имеют недостаток в питьевой воде. Звучит невероятно? Подождите для других фактов!"),
                ("voda-nadom.ru", "Влияние воды на наш организм", UIImage(named: "voda-nadom"), "https://voda-nadom.ru/stati/vliyanie-vody-na-nash-organizm/", "Нормальная работа человеческого организма невозможна без регулярного употребления чистой питьевой воды. В случае отсутствия жидкости организм человека перестает работать нужным образом. Впоследствии это может привести не только к сбою в работе жизненно важных органов, но и даже к их полному отказу. Поэтому так важно следить за уровнем жидкости в организме."),
                ("ecomaster.ru","10 причин не пить воду",UIImage(named: "ecomaster"),"https://ecomaster.ru/articles/10-prichin-pit-vodu", "Человек примерно на 75 % состоит из воды, но он непрерывно расходует ее запасы. Чтобы их восполнять и не доводить себя до обезвоживания, необходимо соблюдать определенный питьевой режим. Это позволит поддерживать водный баланс организма и заботиться о своем здоровье. Вода - важное составляющая живых клеток. Недостаток этой ценной жидкости неизбежно ведет к сбою в функционировании органов и систем организма. Соблюдение питьевого режима, напротив, позволяет улучшить самочувствие, настроение, внешний вид и даже предотвратить серьезные заболевания. Таким образом, ежедневно употребляя 8-10 стаканов чистой воды, вы сможете отметить многочисленные благоприятные изменения в своем состоянии и существенно сократить количество визитов к врачу.")
]
