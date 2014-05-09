describe 'Person', ->

  it 'has a name', ->
    person = new GameOfTheGoose.Person
      name: 'Henk'
    expect(person.name).toEqual('Henk')

