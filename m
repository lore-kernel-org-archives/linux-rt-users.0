From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Thu, 31 May 2007 11:56:11 -0400
Message-ID: <20070531155611.GA9207@goodmis.org>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org> <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu> <46574DE4.2080900@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759910AbXEaP5Y@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46574DE4.2080900@rncbc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Fri, May 25, 2007 at 09:58:12PM +0100, Rui Nuno Capela wrote:
>
> I wish I could give you more details, but the fact is I don't know
> where
> to look. The machine just freezes silently, again and again, with all
> kernels from -rt2 to -rt8 inclusive, with no traceable evidence, at
> least to my knowledge. The only symptom that I can come about is that,
> from some moment on and ever since, the system cannot start any new
> process anymore, or otherwise takes forever to realize and launch any
> new started process thread.
>

I have a box that looks like it's doing the same thing. Unfortunately
for now it's being used to test other things.

But I did do a show-task and see a bunch of D processes. I'll post that
output when I get that box free again.

-- Steve
