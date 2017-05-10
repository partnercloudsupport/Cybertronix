import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'cards/job.dart';
import 'drawer.dart';
import 'firebase.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage();

  @override
  AgendaPageState createState() => new AgendaPageState();
}

class AgendaPageState extends State<AgendaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> agenda;
  Future<Map<String, Map<String, Map<String, dynamic>>>> agendaData = getAgendaData();

  Widget buildAppBar(){
    return new AppBar(
      title: new Text('Your Agenda'),
    );
  }
  
  Widget buildFloatingActionButton() {
    return new FloatingActionButton(
      tooltip: 'Add todo job',
      child: new Icon(Icons.add),
      onPressed: null
    );
  }

  void popupJobCard(BuildContext context, String jobId, Map<String, dynamic> jobData){
    showDialog(
      context: context,
      child: new JobCard(jobId, jobData)
    );
  }

  void buildAgenda() {
    agenda = [];
    agendaData.then((value) {
      value.forEach((day, jobs) {
        DateTime date = DateTime.parse(day);
        DateFormat formatter = new DateFormat('EEEE, MMMM d');
        String txt = formatter.format(date);
        List subJobs = [];
        if (jobs.length == 0) {
          setState((){
            subJobs.add(new ListTile(
              title: new Text("No jobs scheduled.")
            ));
          });
        } else {
          jobs.forEach((id, job) {
            DateTime jdt = DateTime.parse(job["datetime"]);
            DateFormat time = new DateFormat.jm();
            setState((){
              subJobs.add(new ListTile(
                title: new Text('${time.format(jdt)}, ${job["name"]}'),
                onTap: () {
                  popupJobCard(context, id, job);
                }
              ));
            });
          });
        }
        setState((){
          agenda.add(new ExpansionTile(
            title: new Text(txt),
            leading: new CircleAvatar(child: new Text(jobs.length.toString())),
            children: subJobs
          ));
        });
      });
    }); 
  }

  @override
  void initState(){
    super.initState();
    buildAgenda();
  }

  int builds = 0;

  @override
  Widget build(BuildContext context) {
    builds++;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      floatingActionButton: buildFloatingActionButton(),
      drawer: buildDrawer(context, 'agenda'),
      body: new Center(
        child: new ListView(
          children: new List.from(agenda)
        ),
      ),
    );
  }
}