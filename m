From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 14:56:22 -0800
Message-ID: <5bdc1c8b0801131456h10bb6ab6h7445424c59aeaa26@mail.gmail.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:16932 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYAMW4X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 17:56:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3279660wah.23
        for <linux-rt-users@vger.kernel.org>; Sun, 13 Jan 2008 14:56:22 -0800 (PST)
In-Reply-To: <1200250801.9190.7.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Jan 13, 2008 11:00 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> We are pleased to announce the 2.6.24-rc7-rt1 tree, which can be
> downloaded from the location:
>
>   http://rt.et.redhat.com/download/
>

Up and running here. No significant testing but no problems building
it and no obvious regressions from 2.6.24-rc2-rt1.

mark@lightning ~ $ uname -a
Linux lightning 2.6.24-rc7-rt1 #1 PREEMPT RT Sun Jan 13 14:41:21 PST
2008 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $

- Mark
