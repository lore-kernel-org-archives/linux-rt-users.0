From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 03/21] ring-buffer: Add TIME_EXTEND_ABS ring buffer
 type
Date: Fri, 10 Feb 2017 09:28:18 -0500
Message-ID: <20170210092818.238aab14@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <a27fc1371e12174ee9f806d67d0c60844ebbe04c.1486569306.git.tom.zanussi@linux.intel.com>
        <20170208153200.38be2965@gandalf.local.home>
        <20170210060451.GA14705@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, <tglx@linutronix.de>,
        <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210060451.GA14705@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 10 Feb 2017 15:04:51 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > 
> > But it would require comments and/or a wrapper to define it so people
> > in the future know what it is doing.  
> 
> What about
> 
> 	event->type_len >= RINGBUF_TYPE_TIME_EXTEND
> 
> ?  I think it's easier to understand what it's doing.
> 

Either way, I'd like to have it defined as a macro.

-- Steve
