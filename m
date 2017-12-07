From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 2/5] perf-probe: Cut off the version suffix from event
 name
Date: Thu, 7 Dec 2017 14:55:29 -0300
Message-ID: <20171207175529.GI3173@kernel.org>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
 <151263122864.13843.10998234736675352577.stgit@devbox>
 <20171207165659.GD3173@kernel.org>
 <8f1f552c-c5d0-40e3-14d9-96a4a38b33c6@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8f1f552c-c5d0-40e3-14d9-96a4a38b33c6@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Thu, Dec 07, 2017 at 11:24:47AM -0600, Paul Clarke escreveu:
> On 12/07/2017 10:56 AM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Dec 07, 2017 at 04:20:28PM +0900, Masami Hiramatsu escreveu:
> > See also Paul Clarke's question and suggestion, which I agree, i.e.
> > instead of chopping off the version, just replace the chars with valid
> > ones or better, do what Paul suggests, be more flexible in interpreting
> > @, i.e. if it is a number and/or fails to point to any file, interpret
> > it as versioning.
 
> It's a nit, and subjective, but I'd favor checking for versioning
> first, then file.  The namespaces are very unlikely to intersect, but
> I could foresee symbols like "sym@implA.c" and "sym@implB.c" more
> likely than a symbol in a file "GLIBC_2.2.5".
 
> Perhaps straying toward bikeshedding...

Nah, those are valid concerns, and I share them.

- Arnaldo
