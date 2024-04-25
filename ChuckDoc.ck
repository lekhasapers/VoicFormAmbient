VoicForm voc => NRev n => Chorus chorus => Echo a => Echo b => Echo c => dac;
SqrOsc bass => Modulate x => Echo g => Echo h => dac; 

880.0 => voc.freq;
1.0 => voc.gain;
2.0 => n.gain;
0.5 => n.mix; 
1000::ms => a.max => b.max => c.max;
750::ms => a.delay => b.delay => c.delay;
0.50 => a.mix => b.mix => c.mix;
//990.0 => chorus.modFreq;
2.0 => chorus.modDepth; 
1.0 => x.vibratoRate;
0.7 => x.vibratoGain;
0.4 => x.randomGain; 
0.5 => g.mix;
0.5 => h.mix;


440.0 => bass.freq;




fun void mod( )
{
    0.0 => float decider;
    0.0 => float mix;
    0.0 => float old;
    0.0 => float inc;
    0 => int n;
    
    while( true )
    {
        Math.random2f(0.0,1.0) => decider;
        
        if( decider < .3 ) 0.0 => mix;
        else if( decider < .6 ) .08 => mix;
        else if( decider < .8 ) .5 => mix;
        else .7 => mix;

        (mix-old)/1000.0 => inc;
        1000 => n;
        while( n-- )
        {
            old + inc => old;
            if( old < 0 ) 0 => old;
            old => a.mix => b.mix => c.mix;
            1::ms => now;
        }
        mix => old;
        Math.random2(2,6)::second => now;
    }
}

spork ~ mod();
1.0 => voc.loudness;
0.01 => voc.vibratoGain;


[ 0, 2, 4, 7, 9 ] @=> int scale[];

1::second => dur beat;

while(true) {
    
    Math.random2f(0.2, 0.7) => voc.noteOn;
    
    if( Math.randomf() > 0.85 )
    { 200::ms => now; }
    else if( Math.randomf() > .85 )
    { 300::ms => now; }
    else if ( Math.randomf() > .1 )
    { 550::ms => now; }
    
    Math.random2f(0.4, 0.7) => voc.noteOn;
    scale[Math.random2(0,scale.size()-1)] => int freq;
    Std.mtof( ( 45 + Math.random2(0,2) * 12 + freq ) ) => voc.freq;
    
    Math.random2f(0.3, 0.5) => bass.gain;  
    Math.random2f(40.0, 100.0) => bass.freq;
         

    beat => now; 
    

    

}
