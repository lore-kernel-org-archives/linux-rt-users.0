From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest usage
Date: Fri, 2 Jun 2017 09:26:12 -0500
Message-ID: <20170602092612.4069fe8f@tagon.lan>
References: <20170526112502.4f6a49ac@tagon>
        <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/=ARl+uaZlN95/aXk7rOpEll"; protocol="application/pgp-signature"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbdFBO0e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 10:26:34 -0400
In-Reply-To: <20170602095911.wlqcvsi6zf336z5l@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/=ARl+uaZlN95/aXk7rOpEll
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jun 2017 11:59:11 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-05-26 11:25:02 [-0500], Clark Williams wrote:
> > What we're looking for is how people are using cyclictest. For example,=
 at Red Hat we use the 'rteval' tool, which puts a large SCHED_OTHER load o=
n the system and then runs cyclictest with a measurement thread on each cor=
e. The intent is to put a large load on the scheduler and prove that the RT=
 patchset provides deterministic performance under load.=20
> >=20
> > What other types of testing/measurement are people doing with cyclictes=
t? =20
>=20
> hackbench, disk I/O, network related ping/traffic for the "normal"
> interfaces and some custom ones to poke at the gpio, i2c, =E2=80=A6 drive=
rs to
> ensure that they don't a long off time. Either way, I prefer starting
> them independently of cyclictest.

Yeah, that's the *other* tool we should discuss some time: rteval. Currentl=
y the only loads rteval has are 'kcompile', which is a parallel make of a k=
ernel tree and 'hackbench' which kicks off a bunch of hackbench instances. =
I've been thinking about adding a 'stress' load to use the stress app, but =
just haven't had time.=20

And of course the only measurement module for rteval is cyclictest. Haven't=
 really figured out what would be another good measurement module.=20


>=20
> > John Kacur and I are wanting to clean up tracing and make sure that the=
 most commonly used options are on by default. In addition we want to refac=
tor some of the runtime logic. Are there other areas that need to be cleane=
d up? Features that need to be added/deleted? =20
>=20
> I do have (had) a tiny version of cyclictest with a lot things pulled
> out simply to get it run a system with 8 MiB RAM in total. Learned from
> this: everything out :)
> Basically the only interaction between cyclictest and the tracing
> infrastructure should be just to stop tracing only if a break value was
> specified _and_ was the reason for cyclictest to abort.
> This would also reduce the number of command line options which would
> _really_ nice.=20

That's exactly the plan. Rip out the tracing bits (except for -b/--breaktra=
ce) and their associated command line args.=20

> As for defaults, it should be have those arguments which are used by
> people by default. I guess this includes clock_nanosleep(), mlockall(),
> very high priority, one thread per-core and so on.
> Not sure about "-d 0 --secaligned 250" but something should be default
> so we have the same behaviour on its invocation.

When rteval starts cyclictest it uses '-d0 -i100'. I know that's the worst =
case of having every timer interrupt fire at the same time, but when we sta=
rted this that's what we wanted to see. Do we need to have two meta-argumen=
ts: --worst-case / --best-case? The --worst-case would do things most norma=
l deployers of a realtime app wouldn't do, while the --best-case would stag=
ger timer starts, isolate to numa nodes, etc.=20

> I remember, that there was (or is) an option to figure out if the
> hrtimer is working on the system and estimates the resolution of the
> clocksource. I would move that into a different tool.
> That -M mode is nice, but it should give some kind of indication, that
> the system is still alive like update the number of "loop" once in a
> while. But this brings me to another topic: The output system. Usually
> the console output is enough. Then we have the "histogram" mode to check
> the distribution. People often use the histogram mode because the former
> can't be used/parsed by script/tool. Here (the histogram) I hear people
> complaining about the output which is not (easy)
> machine-readable. *I* think it would be okay to use the "histogram" mode
> for machine-readable but the output should be better structured.
> Something like yaml is probably just fine. However I can't tell if this
> will work for everyone or if a plugin-like interface would be best so we
> can dock yaml output as well as something that creates xml based output
> (for people that dream in XML, too).

I don't have a problem generating XML or JSON or some sort of structured ou=
tput. I'll put that on the list. Hmmm, plugins...

Regarding periodic updates, what do you think about providing a way for an =
app to query the current state of a run? Possibly a memory region that can =
be mmapped by a process? Or possibly a UNIX domain socket? I'm thinking of =
the case where you're doing a 48 hour test run on a box where you don't hav=
e easy access to the console and would just like to know if a) the box is a=
live and b) is still showing reasonable values for max latency and jitter.=
=20

I kinda like the memory region since that's how cyclictest handles output: =
the measurement threads all dump their data into a cpu-specific memory area=
 and a display thread (running at a low priority) is the one that wakes up,=
 reads the update and printf's to the screen. If we exported that region so=
 that another process could mmap it read-only, that would provide a way to =
get a snapshot of the run, without actually depending on cyclictest to *do*=
 anything out of the ordinary.=20

Thanks for the input Sebastian.=20

Clark

--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_/=ARl+uaZlN95/aXk7rOpEll
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZMXWEAAoJEBO1XdB8U7hRuAUP/iCHOXNjCEZMEX8kPVtTLidb
tlCm/f9ls3xbri3Q71zFNQ4ytJ1c6OLqj+dwPRtq7Eyr7zRHfhYWnquzQSNrRSmZ
DWAgckc9nq3gjmcqDDeEientpjHoWy3OZDy9nt/hTA7rCoTvT8JeJIWsl9IxHtmI
GTv6zLnUQJfyTPkSGAFxAnPLmNfRI8tj0INNbHWw9HJzh/ym2qVofg6kAHfn+ji3
136smFddN3ftkuKMPQ8OzD6puXWknEKMJE2s+IiB068h9ADz0wzpvbs2M6RjoV3U
4Yt6Ch+UUV4Fpzzh9eKUD5i4bVc13phAgG7arafXMFQMkUsOamJYzzNPHRSzTsLM
h0lYFo/TZzkNt7PHCchy13TqPi/WBtl7YR/UnbCWt1dVQFeOQHCDCxx/a7EqtICs
Ms3q/NQZ16vjee/e+sihAccEKwCnvItR5RVwK8Y5eHn4kdCTgE8N73DXy/yQJDI9
4bXQEcp9cWnX8sMt9lyKsqdGkVHwHA9FY5L+/9CvK4gSNahbijGXRVBXf2MYsZCS
4if4Y8oAo1m65pCu52DQL0g797A67jjpcYeEq/AwBytj3Lwwl5wfO1rNiJsqTsvZ
ntO52qN0cObdQvfarACkg9Pq+bOnGw7xZcoOqlQvqZRcjOqkicNc4G3tEWgmFU+g
d5x/O7TvovuTFUIQiwFG
=QVID
-----END PGP SIGNATURE-----

--Sig_/=ARl+uaZlN95/aXk7rOpEll--
