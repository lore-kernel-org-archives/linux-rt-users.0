From: Thomas Sattler <sattler@med.uni-frankfurt.de>
Subject: Re: Fwd: BUG: scheduling while atomic: chcpu/6197/0x00000002
Date: Wed, 27 Jun 2012 15:32:06 +0200
Message-ID: <4FEB0B56.9050509@med.uni-frankfurt.de>
References: <4FDF00CB.7090703@med.uni-frankfurt.de>  <4FDF201E.2090408@med.uni-frankfurt.de>  <4FE19494.6000303@med.uni-frankfurt.de>  <4FE86067.9010408@med.uni-frankfurt.de>  <4FEAF165.9090008@med.uni-frankfurt.de>  <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com> <1340800622.16702.1.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout.rz.uni-frankfurt.de ([141.2.22.233]:40757 "EHLO
	mailout.rz.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756040Ab2F0NwZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 09:52:25 -0400
In-Reply-To: <1340800622.16702.1.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I believe CPU hotplug is still an issue with -rt, and
> this is a known problem.

Is there an (un-)official list of known problems? I'd
like to help by reporting issues without repeating
already known issues over and over again. :-)

Thomas
