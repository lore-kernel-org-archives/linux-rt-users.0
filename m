From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Date: Wed, 19 Dec 2018 09:00:08 -0600
Message-ID: <1545231608.4491.0.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219114517.GA19177@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219114517.GA19177@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Wed, 2018-12-19 at 20:45 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Tue, Dec 18, 2018 at 02:33:19PM -0600, Tom Zanussi wrote:
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
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 

Thanks!

Tom
