From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 00/16] tracing: Hist trigger snapshot and onchange
 additions
Date: Thu, 29 Nov 2018 23:54:07 +0900
Message-ID: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
        <1543267288.2529.25.camel@kernel.org>
        <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuah@kernel.org>
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 29 Nov 2018 22:52:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > For that system, I'm using Gnome terminal 3.24.2 and GNU bash, version
> > 4.4.12(1)-release (x86_64-pc-linux-gnu) (Ubuntu 17.10).
> > 
> > If I change 'echo' to '/bin/echo' in e.g. prlog() it works fine, so it
> > must be the inbuilt bash echo that's not doing the right thing.  I
> > thought it might be the xpg_echo option, but 'shopt -s xpg_echo'
> > doesn't have any effect.
> > 
> > I also tried on a Fedora 28 system (GNOME terminal 3.28.2, GNU bash,
> > version 4.4.23(1)-release (x86_64-redhat-linux-gnu), and it worked
> > fine.
> > 
> > Also, tried a Ubuntu 18.04.1 system (GNOME Terminal 3.28.1, GNU bash,
> > version 4.4.19(1)-release (x86_64-pc-linux-gnu) and in that case the
> > colors worked fine, but still got the '-e -n' and newlines in the
> > output:
> > 
> > -e -n [28] (instance)  event trigger - test histogram modifiers
> > -e 	[PASS]
> > -e -n [29] (instance)  event trigger - test histogram trigger
> > -e 	[PASS]
> > 
> > Again, substituting '/bin/echo' in prlog() fixed things in this case
> > too.   I guess the builtin bash 'echo' can't be relied on..
> 
> OK, then we should use /bin/echo for avoiding this issue.


Ah, I found that usually ubuntu system use "dash" instead of
"bash" for the alias of "sh", and its builtin echo command doesn't
accept "-e". So if the first option is "-e", it treats all arguments
are output string, including -e.

Anyway, still using /bin/echo is the best solution.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
