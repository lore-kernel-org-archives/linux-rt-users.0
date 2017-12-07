From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/5] perf-probe: Improve probing on versioned symbols
Date: Thu, 7 Dec 2017 15:11:03 +0900
Message-ID: <20171207151103.38554540d085bf76fb5a6b7c@kernel.org>
References: <151252958056.12861.954203514347167563.stgit@devbox>
        <0db660f7-2211-39b0-7491-7fb3cc4fbb8f@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <0db660f7-2211-39b0-7491-7fb3cc4fbb8f@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 7 Dec 2017 10:13:28 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Hi Masami,
> 
> 
> On 12/06/2017 08:36 AM, Masami Hiramatsu wrote:
> > [4/5] Find versioned symbol from map without wildcard.
> >    This allows user to specify a symbol without version
> >    suffix nor wildcard. Anyway, at this point we have
> >    no way to specify version suffix, because parser
> >    recognizes "@" is a separator of "function@file"
> >    syntax. This is fixed in next patch.
> > [5/5] Allow user to use backslash-escaped characters
> >    on command line. This has 2 effects, user can specify
> >    version suffix directly, and we can use special
> >    characters in source file.
> 
> Just a thought. Will it be good to describe / illustrate this
> in man page as well?

Good catch! I forgot that...

Thanks!


> 
> Thanks,
> Ravi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
