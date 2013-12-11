From: David Miller <davem@davemloft.net>
Subject: Re: [BUG] stable v3.10.16+ introduced by "ip6tnl: allow to use
 rtnl ops on fb tunnel"
Date: Wed, 11 Dec 2013 16:53:31 -0500 (EST)
Message-ID: <20131211.165331.495095016561766264.davem@davemloft.net>
References: <20131113211430.1ad3bb7d@gandalf.local.home>
	<20131209002531.GB14382@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, nicolas.dichtel@6wind.com,
	williams@redhat.com, linux-rt-users@vger.kernel.org,
	lclaudio@uudg.org
To: gregkh@linuxfoundation.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131209002531.GB14382@kroah.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 8 Dec 2013 16:25:31 -0800

> On Wed, Nov 13, 2013 at 09:14:30PM -0500, Steven Rostedt wrote:
>> +++ b/net/ipv6/ip6_tunnel.c
>> @@ -1731,8 +1731,6 @@ static void __net_exit ip6_tnl_destroy_tunnels(struct ip
>>                 }
>>         }
>>  
>> -       t = rtnl_dereference(ip6n->tnls_wc[0]);
>> -       unregister_netdevice_queue(t->dev, &list);
>>         unregister_netdevice_many(&list);
>>  }
>>  
>> 
>> Which, when applied to 3.10.18, fixes the bug. Was there a reason that
>> this part of the commit wasn't backported? or was this just an oversight?
> 
> It looks like it was left out to me as well.
> 
> David, any objection to me making this fixup in the 3.10-stable tree?

The original patch submitted told me to leave this part of the patch
out of the backport, explaining that it wasn't necessary in older
kernels.

Can someone please sort this out?

Nicolas please provide some guidance here, thanks.
