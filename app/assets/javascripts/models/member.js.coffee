CsoChorus.MemberStatus = DS.Model.extend
  description: DS.attr('string')

CsoChorus.Member = DS.Model.extend
  firstName: DS.attr('string')
  lastName: DS.attr('string')
  voicePart: DS.belongsTo('CsoChorus.VoicePart')
  memberStatus: DS.belongsTo('CsoChorus.MemberStatus')

  fullName: (->
    @get('firstName') + ' ' + @get('lastName')
  ).property('firstName', 'lastName')

  isActive: (-> @get('status_id') == 1).property('status_id')

CsoChorus.VoicePart = DS.Model.extend
  abbreviation: DS.attr('string')
  description: DS.attr('string')
  part: DS.attr('string')
  section: DS.attr('number')
