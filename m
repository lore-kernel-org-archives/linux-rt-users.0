From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: [Announce] 2.6.29-rc6-rt3
Date: Mon, 9 Mar 2009 11:44:38 -0400
Message-ID: <f96d234e0903090844y4e08f2b0l13b2a6554056a53c@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <f96d234e0903061423j4820acefie0cd7d7bf9089b16@mail.gmail.com>
	 <1236421237.6376.114.camel@laptop> <20090308102509.GA21557@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:23384 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZCIPok convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2009 11:44:40 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1713416rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2009 08:44:38 -0700 (PDT)
In-Reply-To: <20090308102509.GA21557@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Mar 8, 2009 at 6:25 AM, Ingo Molnar <mingo@elte.hu> wrote:

>
> the full commit is the one below. I've attached the bad config -
> the build bug might have been fixed meanwhile.
>
> =A0 =A0 =A0 =A0Ingo
>
> --------------->
> From 50f971ad73ea9550b1d8e34006bd11c7e108b24f Mon Sep 17 00:00:00 200=
1
> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed, 22 Oct 2008 06:15:21 +0200
> Subject: [PATCH] qa: disable jffs2 for now
>
> fs/jffs2/nodemgmt.c: In function 'jffs2_find_nextblock':
> fs/jffs2/nodemgmt.c:265: error: 'struct jffs2_sb_info' has no member =
named 'wbuf_ofs'
> fs/jffs2/nodemgmt.c:265: error: 'struct jffs2_sb_info' has no member =
named 'wbuf_len'
> fs/jffs2/nodemgmt.c:266: error: 'struct jffs2_sb_info' has no member =
named 'wbuf_ofs'

This appears to be fixed, as I did not observe any compile problems
after re-enabling JFFS2.

Thanks,
Cliff

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cliff Brake
http://bec-systems.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
