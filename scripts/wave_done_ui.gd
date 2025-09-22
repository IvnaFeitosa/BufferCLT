extends Control

func set_text_for_money(money: int):
	$WaveDoneText/MoneyReward.text = "+$" + str(money) + " received"
func play_anim():
	$AnimationPlayer.play("text_anim")
