$ = document.querySelector.bind(document)

rand = (n) -> Math.floor Math.random() * n

currentCountdown = 0
countdownTimer = null

updateCountdown = ->
  currentCountdown--
  $('#countdown').textContent = currentCountdown
  return done() if currentCountdown is 0

countdown = (n) ->
  currentCountdown = n
  $('#countdown').textContent = currentCountdown
  countdownTimer = setInterval updateCountdown, 1000

numbers = []

lpad = (str, n) ->
  str = '' + str
  str = ' ' + str while str.length < n
  str

done = ->
  clearInterval countdownTimer
  countdownTimer = null
  sum = (numbers.reduce (a, b) -> a + b)
  if $('#mode').value is 'avg'
    actual = sum / numbers.length
  else
    actual = sum
  text =
    if answer = $('#answer').value
      "Actual:#{lpad actual, 4}, Yours:#{lpad answer, 4}, Difference: #{Math.abs(actual-answer)}"
    else
      "Too slow! #{actual}"
  $('#results').textContent = text + "\n" + $('#results').textContent

genNumbers = (count, sum) ->
  splits = (Math.random() for [1..count-1])
  splits.push(1)
  splits.unshift(0)
  splits.sort (a, b) -> a - b

  ret = []
  for n, i in splits
    n2 = splits[i+1]
    ret.push Math.round((n2-n)*sum) if n2
  ret

go = ->
  countdown 5
  total = Math.round Math.random()*1000
  console.log "total", total
  # numbers = (rand 99 for [1..10])
  numbers = genNumbers 10, total
  $('#numbers').textContent = numbers.join('\n')
  $('#answer').value = ""
  $('#answer').focus()

$('#ready').addEventListener 'click', go
$('#answer').addEventListener 'keyup', (e) ->
  if e.which is 13
    if countdownTimer
      done()
    else
      go()