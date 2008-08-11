From: "Tobias Knutsson" <tobias.knutsson@gmail.com>
Subject: Cyclictest usage
Date: Mon, 11 Aug 2008 11:00:19 +0200
Message-ID: <ccb913ac0808110200m7a34b361j5a60e9ef31ebb0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:4608 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbYHKJAU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 05:00:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3787948wfd.4
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Aug 2008 02:00:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to do some initial benchmarking on a rt-kernel versus a
vanilla kernel. On the rt the results are stable in between test runs
using the following command:

cyclictest -t 1 -p 80 -c 1 -n -i 10000 -l 10000

However, using the same command while running the vanilla kernel, I
get very varying results. And I would completely understand if it was
due to increased jitter. The thing is, the jitter is very low (0%
load) but the average times varies from 600 us to 6500 us depending on
when the test is initiated.

I imagine this might have something to do with not having high res
timers in the vanilla kernel. If that is what's causing my problems.
What is the best way of comparing the two kernels?

I would be much greatful for a few pointers!

--=20

H=E4lsningar/Regards
Tobias Knutsson
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
