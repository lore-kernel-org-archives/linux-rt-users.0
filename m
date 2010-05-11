From: <jpaul@gdrs.com>
Subject: Re: lttctl locks up with RT Linux
Date: Tue, 11 May 2010 16:15:15 -0400
Message-ID: <A47866F933DF804684068A24BF04A9730862A7F0@gdrs-exchange.gdrs.com>
References: <A47866F933DF804684068A24BF04A9730862A74C@gdrs-exchange.gdrs.com>
	<20100422160601.GB28863@Krystal>
	<A47866F933DF804684068A24BF04A97309116C93@gdrs-exchange.gdrs.com>
	<20100511115939.GA17304@Krystal>
	<A47866F933DF804684068A24BF04A9730862A7EB@gdrs-exchange.gdrs.com>
	<20100511151120.GA5013@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, ltt-dev@lists.casi.polymtl.ca,
        linux-rt-users@vger.kernel.org
To: <compudj@krystal.dyndns.org>
Return-path: <ltt-dev-bounces@lists.casi.polymtl.ca>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/options/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=unsubscribe>
List-Archive: <http://lists.casi.polymtl.ca/pipermail/ltt-dev>
List-Post: <mailto:ltt-dev@lists.casi.polymtl.ca>
List-Help: <mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=help>
List-Subscribe: <http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev>,
	<mailto:ltt-dev-request@lists.casi.polymtl.ca?subject=subscribe>
Errors-To: ltt-dev-bounces@lists.casi.polymtl.ca
List-Id: linux-rt-users.vger.kernel.org

Turning off CONFIG_RCU_CPU_STALL_DETECTOR does not solve the issue with starting up "lttctl -C" ... that call never returns. I'm no longer getting the stack dumps in /var/log/messages and I still have to hard reboot the system as soft reboot doesn't work.

JP


-----Original Message-----
From: Mathieu Desnoyers [mailto:compudj@krystal.dyndns.org]
Sent: Tue 5/11/2010 11:11 AM
To: John P. Paul
Cc: ltt-dev@lists.casi.polymtl.ca; Paul E. McKenney; linux-rt-users@vger.kernel.org
Subject: Re: [ltt-dev] lttctl locks up with RT Linux
 
* jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> Thanks Mathieu. I'm going to have to look at this a bit more. This may
> have fixed one problem and cause another as "lttctl -C -w /tmp/trace
> trace1" does not return and I'm getting a stack dump in the messages
> file (see below). The last msg I see from that "lttctl -C" command is
> "lttctl: Creating trace". The "lttctl: Forking lttd" is not displayed.

If you disable RCU stalls detection, does it work ?

[Context for Paul: it's on a -RT kernel, with the LTTng patchset]

Thanks,

Mathieu

--
This is an e-mail from General Dynamics Robotic Systems. It is for the intended recipient only and may contain confidential and privileged information. No one else may read, print, store, copy, forward or act in reliance on it or its attachments. If you are not the intended recipient, please return this message to the sender and delete the message and any attachments from your computer. Your cooperation is appreciated.
