if(boss_inv <= 0)
{
	boss_hp-=2;
	boss_inv=10;
	audio_play_sound(Snd_BossHit,-1,false);
}
