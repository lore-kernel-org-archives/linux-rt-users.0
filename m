From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU stall and the system boot hang
Date: Tue, 1 Dec 2015 11:55:37 -0800
Message-ID: <20151201195537.GA13568@linux.vnet.ibm.com>
References: <CADUONQMsaiTyFPRxm8TfB4ec__XjXUCAhjxZHG8Mz=cExvz5Sw@mail.gmail.com>
 <20151127162809.GM26643@linux.vnet.ibm.com>
 <CADUONQN3yFyFQ8pfkS9u7UAYNjQym8f1JAGapeR9YV4E=7_xXg@mail.gmail.com>
 <20151128145342.GO26643@linux.vnet.ibm.com>
 <CADUONQOYtHvwzoWNW33=WXy5r-UBTqs_vKdeRUgg=YEqq1meWg@mail.gmail.com>
 <20151129060537.GP26643@linux.vnet.ibm.com>
 <CADUONQOc1x_gboKOmigwUX9GrZhukH4KkN1SXRGyjwvXfoGqTg@mail.gmail.com>
 <20151130171918.GR26643@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: fupan li <lifupan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151130171918.GR26643@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 30, 2015 at 09:19:18AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 30, 2015 at 02:54:13PM +0800, fupan li wrote:

[ . . . ]

> > No,  just a normal boot, and these stalls were happened before
> > systemd services running.
>
> Interesting.  My testing show v4.1 being OK, with the first issues showing
> up somewhere between v4.1 and v4.2.  Or at least v4.1 is reliable enough
> that is passes 42 hours of focused rcutorture testing, where v4.2 tends
> to fail in under two hours.  And it seems to happen only on multisocket
> systems -- I seem to be able to hammer as hard as I want on my four-core
> (eight hardware thread) laptop without an issue.

And I take it back.  After beating on it for the better part of a week,
I did get one failure on my single-socket laptop.

So maybe I need to make my rcutorture scripts force tests to cross socket
boundaries where possible...

							Thanx, Paul
