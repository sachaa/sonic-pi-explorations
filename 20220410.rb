bar01 = [ :d3, :bb3, nil, nil, :d3, :f3, nil, nil, :d3, nil, :a3, nil, :d3, :f3, :a3, nil ]
bar02 = [ :e3, :cs3, nil, nil, :e3, :g3, nil, nil, :e3, nil, :b3, nil, :e3, :g3, :bb3, nil ]
melody02 = (ring :d, :r, :r, :a, :f5, :r, :a, :r)

tracks = [
  0, # Melody 1
  1, # Drums
  1, # Melody 2
  1, # Background
]

tempo = 120

live_loop :timer do
  use_bpm tempo
  cue :tick
  sleep 1
end

live_loop :track001 do
  use_bpm tempo
  sync :tick
  use_synth :fm
  if tracks[0] == 1
    with_fx :reverb do
      4.times do
        play bar02.tick
        sleep 0.25
      end
    end
  end
end

live_loop :drums do
  use_bpm tempo
  sync :tick
  if tracks[1] == 1
    sample :bd_boom, amp: 2
    sleep 0.5
  end
end


live_loop :melody02Loop do
  use_bpm tempo
  sync :tick
  if tracks[2] == 1
    use_synth :fm
    with_fx :reverb, room: 0.9 do
      4.times do
        play melody02.tick
        sleep 0.25
      end
    end
  end
end

live_loop :background do
  use_bpm tempo
  if tracks[3] == 1
    with_fx :lpf, cutoff: 60 do |fx|
      with_fx :reverb, room: 0.95 do
        use_synth :saw
        control fx, cutoff_slide: 8, cutoff: 130
        play chord(:d2, :m), release: 10, attack: 0.25, amp: 2
        sleep 8
        control fx, cutoff_slide: 8, cutoff: 60
        play chord(:g2, :m), release: 10, attack: 0.25, amp: 1.6
        sleep 8
      end
    end
  end
end

