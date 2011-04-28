From: Victor henri <nadaeck@hotmail.com>
Subject: How to grant real time to all important threads of an application?
Date: Thu, 28 Apr 2011 04:54:08 +0200
Message-ID: <SNT110-W396E80932BF68003899C93A89B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s15.snt0.hotmail.com ([65.55.90.26]:14460 "EHLO
	snt0-omc1-s15.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752962Ab1D1CyL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Apr 2011 22:54:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello

I hope this is the good place to post this, since the subject is real-t=
ime capacity of a multi-thread application.

I have made an app that displays the harmonics in 3d, and I want to be =
able to run it in real-time;=20

Audio is played with Gstreamer. I have tried to use the 'set_schedparam=
' code, but I got the=20

'Invalid argument' during 'pthread_attr_setschedparam (&attr, &sched)'=20

error... (as well as starting the app with 'chrt -r -p my-pid').=A0 So =
I have used the 'rtpool-test'=20
code from the Gstreamer core examples ( http://cgit.freedesktop.org/gst=
reamer/gstreamer/tree/tests/examples/streams=A0 ) and it
 works.=20

=A0When I run the app, then when I run 'ps -cLe in a terminal, to see a=
ll runing threads of the app,=A0 I see this (the app name is "spectrum3=
d":

=A05265=A0 5265 TS=A0=A0 19 pts/0=A0=A0=A0 00:00:01 spectrum3d
=A05265=A0 5267 TS=A0=A0 19 pts/0=A0=A0=A0 00:00:00 threaded-ml
=A05265=A0 5268 TS=A0=A0 19 pts/0=A0=A0=A0 00:00:00 threaded-ml
=A05265=A0 5270 TS=A0=A0 19 pts/0=A0=A0=A0 00:00:00 task0
=A05265=A0 5271 TS=A0=A0 19 pts/0=A0=A0=A0 00:00:00 spectrum3d
=A05265=A0 5272 RR=A0=A0 90 pts/0=A0=A0=A0 00:00:01 alsasrc:src

The 1st pid is the GTK GUI; the last one must be the gstreamer sound=20
playing, since its policy is RR with a priority of 90; for the record, =
I'd like to run it with the FIFO policy and I have asked Gstreamer how =
to manage that.

but I don't know what the other pid represent... and my question is thi=
s :

The app is written like this :=20
1) GTK GUI with a 'Play" button, that starts playing the sound, with Gs=
treamer, and the 'spectrum' element send messages to the bus that watch=
es gstreamer 'pipeline';=20
2) everytime the "message handler" function of Gstreamer retrives the v=
alues of the spectrum, there is a call to a function that display the v=
alues of the=20
spectrum in a SDL/OpenGL window.=20

So the question is : is the display in the SDL/OpenGL window done also =
with the RR policy or back with TS policy? How can I give real-time to =
the OpenGL process (since it is the most CPU consuming (I'm aware that =
real-time won't change the CPU load, but only change the priorities of =
the scheduler).

Since it is very demanding, I'd like every 'real-time' part of the app =
has real-time policy (not the GTK GUI, I'm aware of that); furhermore, =
keyboard and mouse events are managed with SDL, and touch gestures are =
managed with the libutouch-geis API (multitouch input).

thank u for your help

Victor

Victor 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
