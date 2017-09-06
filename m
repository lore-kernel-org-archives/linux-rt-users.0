From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 02/40] tracing: Add support to detect and avoid
 duplicates
Date: Wed, 6 Sep 2017 14:32:43 -0400
Message-ID: <20170906143243.381a38df@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <7f3ca68455bdac47285ed45d608075a4af287362.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f3ca68455bdac47285ed45d608075a4af287362.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:14 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> From: Vedang Patel <vedang.patel@intel.com>
> 
> A duplicate in the tracing_map hash table is when 2 different entries
> have the same key and, as a result, the key_hash. This is possible due
> to a race condition in the algorithm. This race condition is inherent to
> the algorithm and not a bug. This was fine because, until now, we were
> only interested in the sum of all the values related to a particular
> key (the duplicates are dealt with in tracing_map_sort_entries()). But,
> with the inclusion of variables[1], we are interested in individual
> values. So, it will not be clear what value to choose when
> there are duplicates. So, the duplicates need to be removed.
> 


> [1] - https://lkml.org/lkml/2017/6/26/751

FYI, something like this should have:

Link: http://lkml.kernel.org/r/cover.1498510759.git.tom.zanussi@linux.intel.com

And avoid any non kernel.org archiving system.

-- Steve

> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>
