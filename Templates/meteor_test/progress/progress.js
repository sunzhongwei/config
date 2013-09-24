if (Meteor.isClient) {
  Template.hello.greeting = function () {
    return "Welcome to progress.";
  };

  Template.hello.events({
    'click input[name="start-sync"]' : function () {
      // template data, if any, is available in 'this'
      if (typeof console !== 'undefined')
        console.log("You pressed the button");
    }
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
