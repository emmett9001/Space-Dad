package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    import flash.display.*;

    public class PlayState extends FlxState{
        [Embed(source="../assets/bg.png")] private var ImgBg:Class;
        [Embed(source="../assets/FORCEDSQUARE.ttf", fontFamily="FORCEDSQUARE", embedAsCFF="false")] public var FontHud:String;

        public var _bg:FlxSprite;
        public var debugText:FlxText;
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var m_world:b2World;
        public static var m_physScale:Number = 30

        public var launcher:Launcher = null;

        override public function create():void{
            _bg = new FlxSprite(0,0);
            _bg.loadGraphic(ImgBg,false,false,640,480);
            //add(_bg);

            debugText = new FlxText(10,10,100,"");
            add(debugText);

            setupWorld();

            launcher = new Launcher(m_world);
        }

        override public function update():void{
            super.update();

            launcher.update();

            m_world.Step(1.0/30.0, 10, 10);
            m_world.DrawDebugData();

            timeFrame++;
            if(timeFrame % 50 == 0){
                timeSec++;
            }
        }

        private function setupWorld():void{
            var gravity:b2Vec2 = new b2Vec2(0,9.8);
            m_world = new b2World(gravity,true);

            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            var dbgSprite:Sprite = new Sprite();
            FlxG.stage.addChild(dbgSprite);
            dbgDraw.SetSprite(dbgSprite);
            dbgDraw.SetDrawScale(30.0);
            dbgDraw.SetFillAlpha(0.3);
            dbgDraw.SetLineThickness(1.0);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
            m_world.SetDebugDraw(dbgDraw);

            // Create border of boxes
            var wall:b2PolygonShape= new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;

            // Left
            wallBd.position.Set( -95 / m_physScale, 480 / m_physScale / 2);
            wall.SetAsBox(100/m_physScale, 480/m_physScale/2);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Right
            wallBd.position.Set((640 + 95) / m_physScale, 480 / m_physScale / 2);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Top
            wallBd.position.Set(640 / m_physScale / 2, -95 / m_physScale);
            wall.SetAsBox(680/m_physScale/2, 100/m_physScale);
            //wallB = m_world.CreateBody(wallBd);
            //wallB.CreateFixture2(wall);
            // Bottom
            wallBd.position.Set(640 / m_physScale / 2, (FlxG.height + 70) / m_physScale);
            wallB = m_world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
        }
    }
}
