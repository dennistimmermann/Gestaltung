<div id="article" markdown="1">
<div id="content" markdown="1">

# Von Flächen, Gegensätzen und Raum

## Aufgabe

Die Darstellung von Räumen bedient sich der Hilfe von Flächen in den verschiedensten Formen. Dies ist letztendlich dem darstellendem Medium geschuldet, sei es Papier oder ein Bildschirm, alle sind sie zweidimensional. Gibt es aber Unterschiede zwischen diesen beiden? Lässt sich mit der dynamik eines Bildschirms einfacher oder auf andere Weise eine Plastizität simulieren als auf dem Papier?

## Konzeption

Die erste Handlung war es nach Stift und Papier zu greifen und skizzenhaft unterschiedlichste Methoden zu finden eine räumliche Wirkung entstehen zu lassen. Nach einigem hin und her habe ich mich dann dazu entschieden diese durch Bewegung & Z-Index, Schatten sowie perspektivische Verkürzung in meinen Sketches umzusetzen. Jede der drei Arbeiten sollte dabei eine der Methoden besonders veranschaulichen. Besonderes Augenmerk habe ich darauf gelegt, dass die Sketches zum Start keine Raumwirkung vermitteln und diese erst durch die Interaktion wahrgenommen wird, um die Unterschiede zwischen statischem und dynamischen Medium herauszuarbeiten.

## Umsetzung

Die Umsetzung erfolgte in technischer Hinsicht mithilfe von Processing und dessen 2D-Renderengine.

### Planet of the Shapes

<figure class="sketch">
    <canvas id="movement" data-processing-sources="assets/movement.pde">
        <p>Your browser does not support the canvas tag.</p>
    </canvas>
    <figcaption>Planet of the Shapes</figcaption>
</figure>

Anhand des Z-Index wird dem Betrachter hier eine räumliche Tiefe geradezu aufgezwungen. Durch die Laufbahn verschwindet der Planet beim umrunden der Sonne hinter eben dieser, was in Verbindung mit der Bewegung eine Kreisbahn um die Sonne simuliert und sofort an ein Sonnensystem erinnert. In der Ausgangsposition sind lediglich zwei abstrakte Kreise zu erkennen.

### Bars and Stripes

<figure class="sketch">
    <canvas id="zoom" data-processing-sources="assets/zoom.pde">
        <p>Your browser does not support the canvas tag.</p>
    </canvas>
    <figcaption>Bars and Stripes</figcaption>
</figure>

Zu Beginn besteht die Zeichenfläche lediglich aus drei gleichgroßen nebeneinander angeordneten Rechtecken, welche eher den Eindruck einer Farbtafel vermitteln. Erst durch das Bewegen der Maus in Y-Richtung schrumpft das mittlere Rechteck und dem Betrachter erschließt sich durch die perspektivische Verkürzung der Raum

### You are here

<figure class="sketch">
    <canvas id="shadow" data-processing-sources="assets/shadow.pde">
        <p>Your browser does not support the canvas tag.</p>
    </canvas>
    <figcaption>You are here</figcaption>
</figure>

Ein von vielen Map-Apps bekannter Marker befindet sich auf einer einfarbigen Fläche. Durch starten des Sketches bewegt sich <del>eine Kopie</del> *der Schatten* des Markers langsam nach unten. Hierdurch wird ein Aufstellen des Markers simuliert, welcher gegen Ende senkrecht auf einer Ebene steht.

## Fazit

Auch wenn richtige 3D-Engines ebenfalls nichts anderes machen als einen dreidimensionalen Eindruck auf einem zweidimensionalen Medium zu vermitteln hatte diese Aufgabe einen besonderen Reiz. Mit jeweils nur 3 bis 4 Farben und Flächen wird hier gezielt mit der Wahrnehmung gespielt und all die Technik und Raffinesse der 3D-Engines einfach durch Erfahrungswerte und Erwartungen des Betrachters substituiert.

>
> Dennis Timmermann
</div>
</div>

<script src="assets/processing.js" type="text/javascript"></script>
<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:300|Roboto:400,100,700,100italic,300italic,700italic' rel='stylesheet' type='text/css'>
