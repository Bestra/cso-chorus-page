# For more information see: http://emberjs.com/guides/routing/

CsoChorus.Router.map ()->
  # @resource('posts')
  @resource('members', {path: '/'}, ->
    @resource('member', {path: ':member_id'})
  )
  @resource('directory', {path: '/directory'})

CsoChorus.MembersRoute = Ember.Route.extend
  model: ->
    @store.find('member')
