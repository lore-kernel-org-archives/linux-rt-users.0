From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RT] fs: jbd2: pull your plug when waiting for space
Date: Mon, 10 Mar 2014 13:47:18 -0400
Message-ID: <20140310174718.GB6763@thunk.org>
References: <20140221123253.GA12822@linutronix.de>
 <1392990852.5451.178.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx@linutronix.de
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392990852.5451.178.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 21, 2014 at 02:54:12PM +0100, Mike Galbraith wrote:
> 
> ext3: dbench1 queues a buffer, blocks on journal mutex, it's plug is not
> pulled.  dbench2 mutex owner is waiting for kjournald, who is waiting for
> the buffer queued by dbench1.  Game over.

Where is in ext3/4 are we calling some function which could end up
blocking on kjournald while we have the I/O queue plugged?  That
sounds suspicious and potentially wrong.

							- Ted
