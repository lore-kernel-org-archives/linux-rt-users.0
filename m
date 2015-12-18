From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RFC] rdtscbench: a nohz_full validation and benchmarking
 tool
Date: Fri, 18 Dec 2015 09:40:05 -0600
Message-ID: <20151218094005.2cba4d3d@sluggy.hsv.redhat.com>
References: <1440189958-6959-1-git-send-email-isaac.griswoldsteiner@ni.com>
	<20151211144027.099b2fa0@sluggy.hsv.redhat.com>
	<CAGt1KTzAuFcOez1mq9m1Cs7=dEOyS_Q8aBNfjfdx_x_2Mg0ePg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jkacur@redhat.com, linux-rt-users@vger.kernel.org, joshc@ni.com,
	Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
To: Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901AbbLRPkH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Dec 2015 10:40:07 -0500
In-Reply-To: <CAGt1KTzAuFcOez1mq9m1Cs7=dEOyS_Q8aBNfjfdx_x_2Mg0ePg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 18 Dec 2015 00:36:31 +0000
Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com> wrote:

> On Fri, Dec 11, 2015 at 2:40 PM Clark Williams <williams@redhat.com> wrote:
> 
> > On Fri, 21 Aug 2015 15:45:58 -0500
> > Isaac Griswold-Steiner <isaac.griswold.steiner@gmail.com> wrote:
> >
> > > From: Isaac Griswold-Steiner <isaac.griswoldsteiner@ni.com>
> > >
> > > rdtscbench is a cyclictest-like tool that spawns a thread per cpu. Each
> > thread
> > > measures the difference in cycle count (using the tsc) during the
> > execution of a
> > > tight loop.
> > >
> > > This is a simple tool intended to be used for the validation of
> > nohz_full CPU
> > > configurations. As the validation of nohz_full CPUs is the objective,
> > the tool
> > > avoids the usage of system calls, timers, or anything that might break
> > nohz_full.
> > >
> >
> >
> > Isaac,
> >
> > A question and a request.
> >
> > Was there any particular reason you used sleep() rather than
> > clock_nanosleep() in your cycles_per_second function? I see that you did
> > ten samples but wondered if the slop from a HZ-based wakeup might still
> > introduce some error, as opposed to a more precise programmed wakeup.
> >
> 
> Hi Clark,
> 
> I'm sorry about the delayed response. I made that decision based on the
> idea that if there was jitter (latency) being caused by system calls, I'd
> want a larger measurement of time. That way if there was jitter, it would
> make up a smaller percentage of the total time measured and would have less
> of an impact on the accuracy of the testing tool.
> 
> However this could be totally false, in which case that can be changed.

I made this change which seems to work fine. Let me know what you think:

diff --git a/src/rdtscbench/rdtscbench.c b/src/rdtscbench/rdtscbench.c
index 9bed3e1292d5..7268e7c99469 100644
--- a/src/rdtscbench/rdtscbench.c
+++ b/src/rdtscbench/rdtscbench.c
@@ -113,14 +113,19 @@ static unsigned long long get_cycles_per_second(void)
 {
 	static const int measurements = 10;
 	unsigned long long strt, end, total = 0;
-
+	struct timespec ts;
 	int i = 0;
 
 	printf("# getting cycles per second for %d seconds\n", measurements);
 
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
 	for (i = 0; i < measurements; i++) {
 		strt = get_cycles();
-		sleep(1);
+		if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL) < 0) {
+			fprintf(stderr, "get_cycles_per_second: clock_nanosleep() failed: %s\n", strerror(errno));
+			exit(errno);
+		}
 		end = get_cycles();
 		total += end - strt;
 	}

> 
> 
> >
> > Also, I'd appreciate it if you would expand a bit on the usage section in
> > your README file, specifically how you tune a system prior to running
> > rdtscbench, what output indicates that your tuning is *not* working, versus
> > when to know you're doing the right things. It's probably as simple as
> > saying "if the max latency numbers are spiking you have a problem" but it's
> > good to be explicit about that sort of thing.
> >
> >
> Will do! Thanks for pointing that out.
> 

You're welcome, thanks for the code. I haven't talked to John Kacur about your code yet but it looked useful to me so I'm inclined to pull it in.  Once he and I talk and agree, we'll pull it into the v0.97 devel branch. If we don't agree John will probably be asking you for more changes :).

Clark
