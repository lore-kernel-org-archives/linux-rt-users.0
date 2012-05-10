From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 3/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (3/3)
Date: Thu, 10 May 2012 16:28:50 +0100
Message-ID: <20120510162850.3a61702d@bob.linux.org.uk>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
	<1336048663-21882-3-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1336048663-21882-3-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 3 May 2012 14:37:43 +0200
Ivo Sieben <meltedpianoman@gmail.com> wrote:

> Solved unnecessary schedule latency in the TTY layer when used in
> realtime context:
> The global wait_queue that is used for line discipline idle handling
> is moved to a separate wait_queue for each line instance. This
> prevents unnecessary blocking on one line, because of idle handling
> on another line.
> 
> Note: In a PREEMPT_RT system "normal" spin locks behave like mutexes
> and no interrupts (and therefor no scheduling) is disabled.
> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

And this one as a standalone I think we should merge. I'm surprised it
makes a difference but its small, clean and localises a lock which is a
good thing.

Alan
