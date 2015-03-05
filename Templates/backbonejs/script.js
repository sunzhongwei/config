(function() {
	var Member = Backbone.Model.extend({
		defaults: {
			id: null,
			name: null
		},

		urlRoot: '/member',

		parse: function(rsp, xhr) {
			if(rsp.code === 0){
				var data = rsp.data;
        		return {
					id: data.id,
					name: data.name
				};
      		}
		}
	});

	var MemberCardView = Backbone.View.extend({
		tagName: 'span',

		template: _.template("<%= name %>"),

		initialize: function(member) {
			this.member = member;
			this.listenTo(this.member, "change", this.render);
			this.member.fetch();
		},

		render: function() {
			console.log(1);
			this.$el.html(this.template(this.member.toJSON()));
			$("#member-card").append(this.el);
			return this;
		}
	});

	var m = new Member();
	window.v = new MemberCardView(m);
})();
