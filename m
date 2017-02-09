From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 03/21] ring-buffer: Add TIME_EXTEND_ABS ring buffer
 type
Date: Thu, 9 Feb 2017 09:54:08 -0500
Message-ID: <20170209095408.7c3a8f70@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <a27fc1371e12174ee9f806d67d0c60844ebbe04c.1486569306.git.tom.zanussi@linux.intel.com>
        <20170208153200.38be2965@gandalf.local.home>
        <1486587348.2871.15.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbdBIO41 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2017 09:56:27 -0500
In-Reply-To: <1486587348.2871.15.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 08 Feb 2017 14:55:48 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:


> OK, I'll break it up if I don't see you do anything with it in the
> meantime..

I think I'll let you break it up, and then work on the part that just
handles the implementation of the time stamp. I'll have to see how it
affects trace-cmd too.

-- Steve

