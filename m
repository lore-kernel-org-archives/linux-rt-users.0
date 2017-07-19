From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 16/32] tracing: Add variable support to hist triggers
Date: Wed, 19 Jul 2017 10:07:43 +0900
Message-ID: <20170719010743.GA10107@sejong>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <990cbe4e75a04b81e94220751501d8adeec26804.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <990cbe4e75a04b81e94220751501d8adeec26804.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, Jun 26, 2017 at 05:49:17PM -0500, Tom Zanussi wrote:
> Add support for saving the value of a current event's event field by
> assigning it to a variable that can be read by a subsequent event.
> 
> The basic syntax for saving a variable is to simply prefix a unique
> variable name not corresponding to any keyword along with an '=' sign
> to any event field.
> 
> Both keys and values can be saved and retrieved in this way:
> 
>     # echo 'hist:keys=next_pid:vals=ts0=common_timestamp ...
>     # echo 'hist:key=timer_pid=common_pid ...'
> 
> If a variable isn't a key variable or prefixed with 'vals=', the
> associated event field will be saved in a variable but won't be summed
> as a value:
> 
>     # echo 'hist:keys=next_pid:ts1=common_timestamp:...
> 
> Multiple variables can be assigned at the same time:
> 
>     # echo 'hist:keys=pid:vals=ts0=common_timestamp,b=field1,field2 ...
> 
> Multiple (or single) variables can also be assigned at the same time
> using separate assignments:
> 
>     # echo 'hist:keys=pid:vals=ts0=common_timestamp:b=field1:c=field2 ...

It seems the variable definition can be hard to read if multiple
variables with expression are used.  I think it'd be better to make it
clear what's the key and the values by separating the variable
definition.  For example, the above example can be written as

  # echo 'hist:key=pid:val=ts0:ts0=$common_timestamp:b=field1:...'

I know this is not a good example since the 'ts0' is a simple
reference to the timestamp but it can be more complex..

What do you think?

Thanks,
Namhyung


> 
> Variables set as above can be used by being referenced from another
> event, as described in a subsequent patch.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
