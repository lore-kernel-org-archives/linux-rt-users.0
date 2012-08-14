From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload
Date: Tue, 14 Aug 2012 10:30:28 -0500
Message-ID: <20120814103028.2836b7a6@redhat.com>
References: <1343797643-10208-1-git-send-email-Priyanka.Jain@freescale.com>
	<AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>
	<20120806085929.6c5f8cd7@redhat.com>
	<AC83832D6324604BB08FAE5A33553F1907A94309@039-SN2MPN1-012.039d.mgd.msft.net>
	<AC83832D6324604BB08FAE5A33553F1907A9E244@039-SN2MPN1-012.039d.mgd.msft.net>
	<alpine.LFD.2.02.1208131740280.8203@tycho>
	<AC83832D6324604BB08FAE5A33553F1907A9FB9B@039-SN2MPN1-012.039d.mgd.msft.net>
	<AC83832D6324604BB08FAE5A33553F1907A9FD9F@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/adVsAnhnFQzLVwosAe9I.PB"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab2HNPar (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Aug 2012 11:30:47 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F1907A9FD9F@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/adVsAnhnFQzLVwosAe9I.PB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


My comments inline.

On Tue, 14 Aug 2012 10:15:28 +0000
Jain Priyanka-B32167 <B32167@freescale.com> wrote:

>=20
>=20
> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@v=
ger.kernel.org] On Behalf Of Jain Priyanka-B32167
> Sent: Tuesday, August 14, 2012 2:06 PM
> To: John Kacur; Frank Rowand
> Cc: Clark Williams; linux-rt-users@vger.kernel.org; dvhart@linux.intel.co=
m; rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; Aggrwa=
l Poonam-B10812
> Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
>=20
>=20
> Thanks John and Frank for going through it.
>=20
> As Frank has suggested to make it separate application and  as John also =
pointed out that it is breaking some of cyclic-test features, and also the =
targeted use-case is different, so I think it's better to maintain it as se=
parate tool. Please comments on this.=20

What I'd *really* like to do is pull the common routines out of
cyclictest.c and put them in separate object files, so that we could
create cyclictest-like-tests such as cyclicload without having to cram
the new logic into cyclictest.  As Frank mentioned, cyclictest is
complicated enough and somewhat fragile, so adding new logic tends to
just add new bugs as well.=20

John (and Frank and the test of the CC list) what do you think?


>=20
> Other replies in-lined.
>=20
> Thanks
> Priyanka
>=20
> -----Original Message-----
> From: John Kacur [mailto:jkacur@gmail.com] On Behalf Of John Kacur
> Sent: Monday, August 13, 2012 9:19 PM
> To: Jain Priyanka-B32167
> Cc: Clark Williams; linux-rt-users@vger.kernel.org; dvhart@linux.intel.co=
m; rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330; Aggrwa=
l Poonam-B10812
> Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
>=20
>=20
>=20
> On Mon, 13 Aug 2012, Jain Priyanka-B32167 wrote:
>=20
> > Hello Clark,
> >=20
> > Did you have the chance to test the patch.
> >=20
> > Thanks
> > Priyanka
> >=20
> > -----Original Message-----
> > From: linux-rt-users-owner@vger.kernel.org
> > [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Jain
> > Priyanka-B32167
> > Sent: Tuesday, August 07, 2012 9:32 AM
> > To: Clark Williams
> > Cc: linux-rt-users@vger.kernel.org; dvhart@linux.intel.com;=20
> > rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330;=20
> > Aggrwal Poonam-B10812
> > Subject: RE: [PATCH 1/2][RFC] Add README_cyclicload
> >=20
> > Thanks Clark
> >=20
> > Waiting for the results at your end.
> >=20
> >=20
> > Regards
> > Priyanka
> >=20
> > -----Original Message-----
> > From: Clark Williams [mailto:williams@redhat.com]
> > Sent: Monday, August 06, 2012 7:29 PM
> > To: Jain Priyanka-B32167
> > Cc: linux-rt-users@vger.kernel.org; dvhart@linux.intel.com;=20
> > rostedt@goodmis.org; tglx@linutronix.de; Srivastava Rajan-B34330;=20
> > Aggrwal Poonam-B10812
> > Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload
> >=20
> > Priyanka,
> >=20
> > For some reason all of us that work on rt-tests were busy last week.
> > I'll apply these patches and try out cyclicload this week.
> >=20
> > Clark
> >=20
> > On Mon, 6 Aug 2012 04:00:15 +0000
> > Jain Priyanka-B32167 <B32167@freescale.com> wrote:
> >=20
> > > Hi,
> > >=20
> > > Waiting for the comments on this tool.
> > >=20
> > > Thanks
> > > Priyanka
> > >=20
> > > -----Original Message-----
> > > From: Jain Priyanka-B32167
> > > Sent: Wednesday, August 01, 2012 10:37 AM
> > > To: linux-rt-users@vger.kernel.org; williams@redhat.com;=20
> > > dvhart@linux.intel.com
> > > Cc: rostedt@goodmis.org; tglx@linutronix.de; Srivastava=20
> > > Rajan-B34330; Aggrwal Poonam-B10812; Jain Priyanka-B32167
> > > Subject: [PATCH 1/2][RFC] Add README_cyclicload
> > >=20
> > > Cyclicload program is designed to simulate load at regular intervals =
in form of one or two threads.
> > >=20
> > > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> > > ---
> > >  src/cyclictest/README_cyclicload |  147
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 147 insertions(+), 0 deletions(-)  create mode
> > > 100644 src/cyclictest/README_cyclicload
> > >=20
> > > diff --git a/src/cyclictest/README_cyclicload
> > > b/src/cyclictest/README_cyclicload
> > > new file mode 100644
> > > index 0000000..f1e99bf
> > > --- /dev/null
> > > +++ b/src/cyclictest/README_cyclicload
> > > @@ -0,0 +1,147 @@
> > > +DESCRIPTION
> > > +-------------
> > > +
> > > +The cyclicload program is developed above existing cyclictest applic=
ation.
> > > +It is basically designed to simulate specified load at regular=20
> > > +intervals in addition to cyclictest functionality.
> > > +It can simulate one or two load threads.
> > > +
> > > +
> > > +Why it is required?
> > > +---------------------
> > > +It is required to test system performance under a specified load=20
> > > +along with tracking latency of simulated load thread.
> > > +
> > > +
> > > +Example use case
> > > +--------------------
> > > +For products like LTE, L2 layer runs in form of two threads.
> > > +-MAC layer thread runs at highest RT priority producing a fixed=20
> > > +load at regular intervals and -second thread run at lower RT=20
> > > +priority or in non-rt priority  producing some load in each=20
> > > +interval depending upon availability of CPU.
> > > +Requirement is to test system under this load as well as to track=20
> > > +latency of highest priority RT thread which is MAC thread in=20
> > > +example usecase.
> > > +
> > > +
> > > +What does it do?
> > > +------------------
> > > +It creates one or two load generating thread/s.
> > > +1)load1 thread (timer thread)
> > > +2)load2 thread
> > > +priority, nice value, load % as input via command line
> > > +
> > > +-cyclictest funcationality like latency measurement
> > > +
> > > +
> > > +How does it work
> > > +-----------------
> > > +It uses generate_load loop function to simualte load.
> > > +First it caliberate required loop_count per unit time per CPU.
> > > +It stores this data in some file.
> > > +For subsequent runs, it uses this caliberated data to generate load=
=20
> > > +if form of one or two threads .
> > > +It keeps on tracking the latency of RT thread.
> > > +More in Design Overview section.
> > > +
> > > +
> > > +Recommended Settings
> > > +----------------------
> > > +-First run is recommended to be run with no or least load for accura=
cy.
> > > +-should be run with sudo or root permission.
> > > +-caliberation routine produces calinerate_ount file in runnign direc=
tory.
> > > +	If one don't have permission in that dir, path should be changed in
> > > +	FILENAME or one can exploit shared memory method.
> > > +-Atleast one thread should be of RT priority. This thread takes prio=
rity of
> > > +	cyclictest as its priority.
> > > +-cyclictest applcication should be run with SCHED_OTHER policy.
> > > +-recommended to run in quiet mode (-q) in background.
> > > +TODO: add option to take filepath from cmd line
> > > +
> > > +
> > > +Cmd line usage/examples
> > > +------------------------
> > > +New command line arguments:
> > > + "-x       --load_t1         load in percentage for t1 thread\n"
> > > + "-X       --load_t2         load in percentage for t2 thread\n"
> > > + "-z       --priority_t2     priority of t2 thread\n"
> > > + "-Z       --nice_t2         nice value of t2 thread\n"
> > > +
> > > +If both load_t1 and load_t2 are zero, it behaves as default=20
> > > +cyclictest application
> > > +
> > > +For uniprocessor:
> > > +	#sudo ./cyclictest -p 99 -c 1 -d 0 -x 40 -X 30 -q -D 600&
> > > +
> > > +For multiprocessor:
> > > +	#sudo ./cyclcitest -p 99 -c 1 -d 0 -x 40 -X 30 -q -D 600 -S&
> > > +
> > > +
> > > +
> > > +Future Enhancements
> > > +-------------------
> > > +Maintain statistics of average load produces.
> > > +invalidate cache in each interval to make it close to actual scenari=
o.
> > > +can be scalable to produce n number of load threads.
> > > +
> > > +
> > > +Design Overview
> > > +--------------
> > > +---------------
> > > +
> > > +The logic to simulate load has been added above existing cyclictest =
application.
> > > +
> > > +Threads
> > > +--------
> > > +cyclicload : main process
> > > +--------------------------
> > > +-parse input arguments.
> > > +
> > > +-for first run : create caliberate thread.
> > > +	store caliberated count in caliberate_count file -for subsequent ru=
ns:
> > > +	read caliberated count from file and use that count to simulate def=
ined load.
> > > +
> > > +-create t load1threads (t depending on cmdlime args, for smp system=
=20
> > > +=3D num of cores, one thread per core)
> > > +
> > > +-update stats periodically while !shutdown -print stats=20
> > > +periodically depending on cmdline args while !shutdown
> > > +
> > > +
> > > +caliberate thread
> > > +------------------
> > > +-is created only once for the first run of cyclicload -run at=20
> > > +highest RT priority.
> > > +-affine itself turn by turn to each cpu. (for all cpus for=20
> > > +multicore
> > > +system) -caliberate count per unit (ms by default) per cpu -store=20
> > > +per cpu data in caliberate_count_array -recommended to be run with=20
> > > +no or least load.
> > > +
> > > +
> > > +load1 thread(timer thread)
> > > +---------------------------
> > > +-run at priority parsed in main routine -recommended to run at=20
> > > +highest RT priority -creates load2_thread (optional only if on
> > > +load2 is
> > > +nonzero) -calculate number of loops to execute to generate defined=20
> > > +load by
> > > +	using caliberate_count_array and load percentage parsed in main=20
> > > +routine -reduced interval =3D interval(window) - duration for load_t=
1=20
> > > +-while loop until !shutdown
> > > +	-generate load_t1 load
> > > +	-sleep for reduced interval
> > > +	-calculate latency (cosumes around 1%-2% cpu)
> > > +	-discard off remaining load if window expires
> > > +	-set next_window_started flag to 1
> > > +	-signal load2_thread about next window
> > > +-overhead: consumes 1-2% cpu for latency maintainenance, etc=20
> > > +-variation in produced load : 0%-2% of full cpu utilization
> > > +
> > > +
> > > +load2_thread
> > > +------------
> > > +generate load_t2 load
> > > +wait for next window to start
> > > +if window expires before generate load_t2 finishes,
> > > +	discard off remaining load
> > > +	restart generate load_t2 load
> > > +variation in produced load : 0%-1% of full cpu utilization
> > > --
> > > 1.7.4.1
> > >=20
>=20
> Okay, the patches apply cleanly, and it builds cleanly.
> I admit I didn't look closely at what you're trying to do, but I'm a litt=
le skeptical that this is a real load instead of just a task spinning at an=
 rt prio, but I could be wrong.
> [Priyanka]: Yes John, intention is to create a real cpu load so that we c=
an test the overall system behavior (performance, latency) in presence of t=
his load.
>=20
> However, the major rule when doing stuff in rt-tests is don't break cycli=
ctest!
>=20
> When I tried to run cyclictest with your patches applied, I immediately o=
bserved a lot of broken behaviour, even when I tried your -x0 and -X0 (alth=
ough that shouldn't be necessary).
>=20
> Basically everything moved at a crawl. So, I'm not going to look any clos=
er at this until cyclictest works exactly as before. Sorry.
> [Priyanka]Yes, Sorry for this . It might have broken some of cyclic-test =
functionalities. I hadn't done much testing around them as I was concentrat=
ing more on the target use-case and basic cyclictest functionality.  I hope=
 basic commands like ./cyclictest -S -p 99 -c 1 -d 0 is working fine. Did y=
ou face any issues in this also ?
> I will do more testing around it, but if suggestion is to maintain it as =
separate application then basic functionality should be sufficient. Please =
comment.
>=20
>=20
> I know you are trying to simulate a specific load and not a generic one, =
however you might want to take a look at rteval.
>=20
> rteval basically runs some standard benchmarks such as hackbench and then=
 runs cyclictest at the same time to see if we can break the behaviour of c=
yclictest. Have a look at that too please and see if it might meet your nee=
ds.
>=20
> You can fetch it here.
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rteval.git>
> [Priyanka] : Thanks for the link. I will explore this tool .
> [Priyanka]: Had a look at the tool. It is creating load on the system. Bu=
t that load looks-like is not fixed.
> I have a requirement of creating fixed % load. Like a system having 20% o=
f load of priority 99, 30% load of priority 75, then test system behavior u=
nder this load. Is this possible with this tool?=20

No, rteval is focused on measuring realtime performance with a heavy
SCHED_OTHER load running on the system. So it runs a parallel kernel
make with numcpus*2 parallel jobs, then kicks off the hackbench program
to elevate the context switch rate.  I don't really see a good way to
create a precise system load with rteval.=20

Clark

--Sig_/adVsAnhnFQzLVwosAe9I.PB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAqbxQACgkQHyuj/+TTEp2T5gCgi/OsPtiZtG4C72Zz0Xc53D6G
sbAAn1bmlA0h7FSf7I2FTizYTl0CHykf
=DuCr
-----END PGP SIGNATURE-----

--Sig_/adVsAnhnFQzLVwosAe9I.PB--
