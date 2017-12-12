From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 5/5] perf-probe: Support escaped character in parser
Date: Tue, 12 Dec 2017 12:01:17 -0300
Message-ID: <20171212150117.GM3958@kernel.org>
References: <151275037752.24652.5169845651138876257.stgit@devbox>
 <151275052163.24652.18205979384585484358.stgit@devbox>
 <20171211200330.GI3958@kernel.org>
 <20171212234600.a54ef5601cb4dfdf49e41826@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212234600.a54ef5601cb4dfdf49e41826@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Tue, Dec 12, 2017 at 11:46:00PM +0900, Masami Hiramatsu escreveu:
> On Mon, 11 Dec 2017 17:03:30 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > -		/* We don't care about default symbol or not */
> > > -		ver = strchr(norm, '@');
> > > -		if (ver) {
> > > -			buf = strndup(norm, ver - norm);
> > > -			if (!buf)
> > > -				return -ENOMEM;
> > > -			norm = buf;
> > > +		if (cut_version) {
> > > +			/* We don't care about default symbol or not */
> > > +			ver = strchr(norm, '@');
> > > +			if (ver) {
> > > +				buf = strndup(norm, ver - norm);
> > > +				if (!buf)
> > > +					return -ENOMEM;
> > > +				norm = buf;

> > You forgot a } here, please check this logic and resubmit just this last
> > patch, without the string.c and string2.h part, that I already split
> > from this one and applied.
 
> OOPS! thanks! I missed something around that.... maybe while updating patches.
> Hmm, I might be so upset...
 
> OK, anyway, I'll do that. 

Nah, happens sometimes, one last round of building before submitting
would catch that tho... 8-) :-)

- Arnaldo
