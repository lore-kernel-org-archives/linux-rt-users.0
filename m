From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH RT 6/6] lockstat measurement extensions
Date: Thu, 13 Mar 2008 17:19:49 -0700
Message-ID: <9810cff90803131719p1c2c749eq7cdf9758840e9028@mail.gmail.com>
References: <9810cff90803131703t3626d83fq727b04242f407c13@mail.gmail.com>
	 <9810cff90803131707v4fb3197fv396b8a5e8ae32b4d@mail.gmail.com>
	 <9810cff90803131709m3a5b1e5ep2bfe566b3c3bdb66@mail.gmail.com>
	 <9810cff90803131712l2777d1dex8c25f508369c48e7@mail.gmail.com>
	 <9810cff90803131715h1a93c9a1q86f480cf398d4dfb@mail.gmail.com>
	 <9810cff90803131718ge958e9fo9ae3f43b57f7654c@mail.gmail.com>
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
Received: from qb-out-0506.google.com ([72.14.204.238]:24074 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbYCNATv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Mar 2008 20:19:51 -0400
Received: by qb-out-0506.google.com with SMTP id e11so3658107qbe.15
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2008 17:19:50 -0700 (PDT)
In-Reply-To: <9810cff90803131718ge958e9fo9ae3f43b57f7654c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Last one. Spin checking against the rtmutex->owner's run queue to
determine if an adaptive spin or not is useful.

bill
