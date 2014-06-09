package{
    import org.flixel.*;

    public class OutroState extends FlxState{
        [Embed(source="../assets/end1.png")] private var ImgBg:Class;

        public var bg:FlxSprite;
        public var startTime:Date;
        public var score_text:FlxText;
        public var plushies_delivered:Number = 0;

        public function OutroState(plushies:Number = 0):void{
            plushies_delivered = plushies;
        }

        override public function create():void{
            FlxG.mouse.hide();
            startTime = new Date();

            bg = new FlxSprite(0,0);
            bg.loadGraphic(ImgBg,false,false,320,240);
            add(bg);

            score_text = new FlxText(50,50,300,plushies_delivered.toString() + " plushies delivered! Space Dad is a hero!");
            score_text.color = 0xffffffff;
            add(score_text);
        }

        override public function update():void{
            super.update();

            if(new Date().valueOf() - startTime.valueOf() > 5000){
                FlxG.switchState(new OutroGirlsState());
            }
        }
    }
}