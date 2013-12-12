From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [BUG] stable v3.10.16+ introduced by "ip6tnl: allow to use rtnl
 ops on fb tunnel"
Date: Thu, 12 Dec 2013 10:53:49 +0100
Message-ID: <52A987AD.4030204@6wind.com>
References: <20131113211430.1ad3bb7d@gandalf.local.home>	<20131209002531.GB14382@kroah.com> <20131211.165331.495095016561766264.davem@davemloft.net>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, williams@redhat.com,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org
To: David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131211.165331.495095016561766264.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Le 11/12/2013 22:53, David Miller a =E9crit :
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Sun, 8 Dec 2013 16:25:31 -0800
>
>> On Wed, Nov 13, 2013 at 09:14:30PM -0500, Steven Rostedt wrote:
>>> +++ b/net/ipv6/ip6_tunnel.c
>>> @@ -1731,8 +1731,6 @@ static void __net_exit ip6_tnl_destroy_tunnel=
s(struct ip
>>>                  }
>>>          }
>>>
>>> -       t =3D rtnl_dereference(ip6n->tnls_wc[0]);
>>> -       unregister_netdevice_queue(t->dev, &list);
>>>          unregister_netdevice_many(&list);
>>>   }
>>>
>>>
>>> Which, when applied to 3.10.18, fixes the bug. Was there a reason t=
hat
>>> this part of the commit wasn't backported? or was this just an over=
sight?
>>
>> It looks like it was left out to me as well.
>>
>> David, any objection to me making this fixup in the 3.10-stable tree=
?
>
> The original patch submitted told me to leave this part of the patch
> out of the backport, explaining that it wasn't necessary in older
> kernels.
Yes, and this was right (in upstream commit, I remove this part because
the fb device is deleted by the loop which check dev->rtnl_ops) , but .=
=2E.

>
> Can someone please sort this out?
>
> Nicolas please provide some guidance here, thanks.
The original patch left a bug, which was fixed upstream with this commi=
t:
1e9f3d6f1c40 ip6tnl: fix use after free of fb_tnl_dev

The problem is a bit different in 3.10.y, because there is no x-vrf sup=
port.
When ip6_tunnel.ko is unloaded, FB device is deleted by rtnl_link_unreg=
ister()
and then we try to delete it again in ip6_tnl_destroy_tunnels().
Thus the fix is different and in fact, the above patch is good.

Steven, will you submit this patch properly or should I do this?
