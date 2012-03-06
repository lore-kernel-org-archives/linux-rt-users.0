From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 04/25][RFC 3.0.23-rt39-rc1]
 revert-seqlock-remove-unused-functions
Date: Tue, 6 Mar 2012 23:42:15 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203062341460.2742@ionos>
References: <20120306161636.491172179@goodmis.org> <20120306161945.770871645@goodmis.org> <CAONaPpFnn1EDh-NbJ5=iKw9q4N41KGVfKqJeO0NXvyTLjpzr4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60251 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031468Ab2CFWmT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 17:42:19 -0500
In-Reply-To: <CAONaPpFnn1EDh-NbJ5=iKw9q4N41KGVfKqJeO0NXvyTLjpzr4w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Mar 2012, John Kacur wrote:
> On Tue, Mar 6, 2012 at 5:16 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> Does this really need to be reverted? I don't believe the other
> reverts make use of these functions either. Looking upstream ,they are
> also not used here, so the original patch should be pushed upstream if
> anything.

It's applied later on again .... :)
