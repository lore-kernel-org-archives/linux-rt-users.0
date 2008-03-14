From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH RT 0/6] lockstat measurement extensions
Date: Thu, 13 Mar 2008 17:26:26 -0700
Message-ID: <9810cff90803131726m55e11b62o5cdebd078626283f@mail.gmail.com>
References: <9810cff90803131703t3626d83fq727b04242f407c13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, pavel@ucw.cz, acme@redhat.com, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: "Gregory Haskins" <ghaskins@novell.com>, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.239]:35365 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYCNA03 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Mar 2008 20:26:29 -0400
Received: by qb-out-0506.google.com with SMTP id o24so1518596qba.1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2008 17:26:27 -0700 (PDT)
In-Reply-To: <9810cff90803131703t3626d83fq727b04242f407c13@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Also, this is not meant for inclusion in it's current revision. It'll
need to have various compilation modes
(CONFIG_PREEMPT_RT/CONFIG_LOCK_STAT) combination enabled and such. I'm
handing this over to Peter Morreale and it'll be up to him to decided
what to do next.

However, it does work and should get interesting numbers for the
discussion of whether or not adaptive spins and friends are useful or
not.

bill
