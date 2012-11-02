From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: [PATCH RT 3/4] net: netfilter: Serialize xt_write_recseq sections
 on RT
Date: Fri, 2 Nov 2012 15:28:05 -0700
Message-ID: <CAN8Q1EfD4LeMiz1UFVzbXafi=ewKLg2myEmXt0L1nLy9VFvRsA@mail.gmail.com>
References: <20121031003258.811955127@goodmis.org>
	<20121031003314.763160265@goodmis.org>
	<CAN8Q1EcHJyDMs-z8Vw_=cpnCL2FO_pATaGThh2UHv4ketC-_Jw@mail.gmail.com>
	<CAN8Q1EfDQi0Lh3215rA9aqzNcn1F5K7OqCLxZYmQ4WgXZyDDUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39078 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab2KBW2H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Nov 2012 18:28:07 -0400
In-Reply-To: <CAN8Q1EfDQi0Lh3215rA9aqzNcn1F5K7OqCLxZYmQ4WgXZyDDUw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On a separate note, I want to thank everyone that helped with this
issue, especially Eric and Thomas, to and Steven and Thomas for
schooling me on the changelog extraction.  This problem was a big one
for us that we were struggling to understand.  All the help is greatly
appreciated.

Thanks,
Pete
