From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 16/32] tracing: Add variable support to hist triggers
Date: Wed, 19 Jul 2017 10:40:28 -0500
Message-ID: <1500478828.23402.2.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <990cbe4e75a04b81e94220751501d8adeec26804.1498510759.git.tom.zanussi@linux.intel.com>
         <20170719010743.GA10107@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719010743.GA10107@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Wed, 2017-07-19 at 10:07 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Mon, Jun 26, 2017 at 05:49:17PM -0500, Tom Zanussi wrote:
> > Add support for saving the value of a current event's event field by
> > assigning it to a variable that can be read by a subsequent event.
> > 
> > The basic syntax for saving a variable is to simply prefix a unique
> > variable name not corresponding to any keyword along with an '=' sign
> > to any event field.
> > 
> > Both keys and values can be saved and retrieved in this way:
> > 
> >     # echo 'hist:keys=next_pid:vals=ts0=common_timestamp ...
> >     # echo 'hist:key=timer_pid=common_pid ...'
> > 
> > If a variable isn't a key variable or prefixed with 'vals=', the
> > associated event field will be saved in a variable but won't be summed
> > as a value:
> > 
> >     # echo 'hist:keys=next_pid:ts1=common_timestamp:...
> > 
> > Multiple variables can be assigned at the same time:
> > 
> >     # echo 'hist:keys=pid:vals=ts0=common_timestamp,b=field1,field2 ...
> > 
> > Multiple (or single) variables can also be assigned at the same time
> > using separate assignments:
> > 
> >     # echo 'hist:keys=pid:vals=ts0=common_timestamp:b=field1:c=field2 ...
> 
> It seems the variable definition can be hard to read if multiple
> variables with expression are used.  I think it'd be better to make it
> clear what's the key and the values by separating the variable
> definition.  For example, the above example can be written as
> 
>   # echo 'hist:key=pid:val=ts0:ts0=$common_timestamp:b=field1:...'
> 
> I know this is not a good example since the 'ts0' is a simple
> reference to the timestamp but it can be more complex..
> 
> What do you think?
> 

Yes, I think that makes sense - I was never a big fan of that syntax
anyway.  I'll make that change in the next version.

Thanks,

Tom
