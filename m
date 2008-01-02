From: Nicholas Miell <nmiell@comcast.net>
Subject: Re: [PATCH 2/2] Markers Implementation for Preempt RCU Boost
	Tracing
Date: Wed, 02 Jan 2008 15:49:03 -0800
Message-ID: <1199317743.2438.8.camel@entropy>
References: <20071231060911.GB6461@in.ibm.com>
	 <20071231102045.GB30380@elte.hu> <y0modc4vr7a.fsf@ton.toronto.redhat.com>
	 <20080102124734.GC11208@elte.hu>  <20080102163309.GC11496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	"K. Prasad" <prasad@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com, ego@in.ibm.com, mathieu.desnoyers@polymtl.ca,
	paulmck@linux.vnet.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758260AbYABXtV@vger.kernel.org>
In-Reply-To: <20080102163309.GC11496@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 2008-01-02 at 11:33 -0500, Frank Ch. Eigler wrote:
> Hi -
> 
> On Wed, Jan 02, 2008 at 01:47:34PM +0100, Ingo Molnar wrote:
> > [...]
> > > FWIW, I'm not keen about the format strings either, but they don't 
> > > constitute a performance hit beyond an additional parameter.  It does 
> > > not need to actually get parsed at run time.
> > 
> > "only" an additional parameter. The whole _point_ behind these markers 
> > is for them to have minimal effect!
> 
> Agreed.  The only alternative I recall seeing proposed was my own
> cartesian-product macro suite that encodes parameter types into the
> marker function/macro name itself.  (Maybe some of that could be
> hidden with gcc typeof() magic.)  There appeared to be a consensus
> that this was more undesirable.  Do you agree?
> 
> 

C++ name mangling would be extremely useful here.


Actually, why isn't the DWARF information for the functions sufficient?

-- 
Nicholas Miell <nmiell@comcast.net>

