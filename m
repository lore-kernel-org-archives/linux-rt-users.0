From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 22:55:17 -0400
Message-ID: <y0mtyzut17u.fsf@fche.csb>
References: <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins>
	<alpine.DEB.1.10.0908261136590.9933@gentwo.org>
	<1251302598.18584.31.camel@twins>
	<alpine.DEB.1.10.0908261211340.9933@gentwo.org>
	<20090826180407.GA13632@elte.hu>
	<alpine.DEB.1.10.0908261509580.9933@gentwo.org>
	<20090826193252.GA14721@elte.hu>
	<alpine.DEB.1.10.0908261627110.5554@gentwo.org>
	<20090826135041.e6169d18.akpm@linux-foundation.org>
	<20090826213400.GA25536@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	peterz@infradead.org, raziebe@gmail.com, maximlevitsky@gmail.com,
	cfriesen@nortel.com, efault@gmx.de, riel@redhat.com,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752206AbZH0C4e@vger.kernel.org>
In-Reply-To: <20090826213400.GA25536@elte.hu> (Ingo Molnar's message of "Wed, 26 Aug 2009 23:34:00 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> [...]
>
>> Don't get all religious about this.  If the change is clean, 
>> maintainable and useful then there's no reason to not merge it.

> Precisely.  This feature as proposed here hinders the correct
> solution being implemented - and hence hurts long term
> maintainability and hence is a no-merge right now.

(Does it "hinder" this in any different way than the following, as in
possibly reducing "pressure" for it?)

> [It also weakens the pressure to fix latencies for a much wider set
> of applications, hence hurts the quality of Linux in the long
> run. (i.e. is a net step backwards)]

How would you differentiate the above sentiment from "perfect is the
enemy of the good"?


- FChE
