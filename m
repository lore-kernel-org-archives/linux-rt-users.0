From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Date: Wed, 19 Dec 2018 09:02:36 -0600
Message-ID: <1545231756.4491.3.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219212739.d5ec4edf7443c3dc1448c8d2@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219212739.d5ec4edf7443c3dc1448c8d2@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2018-12-19 at 21:27 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 18 Dec 2018 14:33:19 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This patchset is a standalone series broken out of the v8 version
> > of
> > the 'tracing: Hist trigger snapshot and onchange additions'
> > patchset.
> > 
> > It's a series of changes resulting from some suggestions from
> > Namhyung
> > for making the variable-reference handling code more understandable
> > through some refactoring and comments.
> > 
> > It also added a new patch changing all strlen() to sizeof() for
> > string
> > constants, in trace_events_hist.c
> > 
> > Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> > management' patch, in create_var_ref(), moved the saving of
> > ref_field
> > and update of ref_field->var_ref_idx into the 'if' as pointed out
> > by
> > Dan Carpenter/smatch 0-day robot.
> > 
> > It doesn't introduce any functional changes and can be applied
> > independently of the other patchset.
> 
> OK, now it is very clear to me :-)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for the series.
> 

Thanks, Masami!

Tom
