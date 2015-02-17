From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-migrate-test: exit early if nr_runs is non-positive
Date: Tue, 17 Feb 2015 17:51:20 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1502171750550.15981@riemann>
References: <5476FAF2.1060702@linux.com> <20150217140838.GP26177@linutronix.de> <54E3508C.3080704@linux.com> <54E351AB.60301@linux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	716237@bugs.debian.org, linux-rt-users@vger.kernel.org
To: Boris Egorov <egorov@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35743 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbBQQvX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 11:51:23 -0500
Received: by mail-wg0-f42.google.com with SMTP id n12so20547681wgh.1
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 08:51:22 -0800 (PST)
In-Reply-To: <54E351AB.60301@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 17 Feb 2015, Boris Egorov wrote:

> Sorry, PROGRESS_CHARS macro is used correctly, but INTERVAL and
> RUN_INTERVAL not. In my opinion, they should be defined and used once in
> static variable assigning, and nowhere else.
> 
> On 02/17/2015 08:30 PM, Boris Egorov wrote:
> > Looks like this patch is not applied yet.
> > 
> > I can move value check to parse_options and send another version of
> > patch. As for macros - yes, I already mentioned them in debian bug
> > report thread. There are three of them (INTERVAL, RUN_INTERVAL,
> > PROGRESS_CHARS) which are improperly (IMO) used instead of corresponding
> > lowercase variables. I thought these changes should go to another patch.
> > 
> > On 02/17/2015 08:08 PM, Sebastian Andrzej Siewior wrote:
> >> * Boris Egorov | 2014-11-27 16:20:34 [+0600]:
> >>
> >>> Program will crash if nr_runs is 0 due to dividing by it in
> >>> print_results(). Let's exit early instead.
> >>>
> >>> Fixes: http://bugs.debian.org/716237
> >>
> >> Has this been dealt with? I can't see this applied. I would prefer
> >> doing the value check in parse_options() itself. And looking at it, it
> >> seems that run_interval is interval ignored. Or is there macro magic
> >> invovled?
> >>
> >>> Signed-off-by: Boris Egorov <egorov@linux.com>
> >>> ---
> >>> src/rt-migrate-test/rt-migrate-test.c | 5 +++++
> >>> 1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/src/rt-migrate-test/rt-migrate-test.c
> >>> b/src/rt-migrate-test/rt-migrate-test.c
> >>> index e3c7a09..876a122 100644
> >>> --- a/src/rt-migrate-test/rt-migrate-test.c
> >>> +++ b/src/rt-migrate-test/rt-migrate-test.c
> >>> @@ -465,6 +465,11 @@ int main (int argc, char **argv)
> >>>  	parse_options(argc, argv);
> >>> +	if (nr_runs <= 0) {
> >>> +		fprintf(stderr, "Warning, --loops argument is non-positive. Exiting.\n");
> >>> +		exit(-1);
> >>> +	}
> >>> +
> >>> 	signal(SIGINT, stop_log);
> >>>  	if (argc >= (optind + 1))
> >>> -- 
> >>> 2.1.3
> >>
> >> Sebastian
> >>
> > 
> 
> -- 
> Best regards,
> Boris Egorov
> --

Awaiting your respin on these patches.

Thanks

John
