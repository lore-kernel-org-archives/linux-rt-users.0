From: Herman ten Brugge <hermantenbrugge@home.nl>
Subject: Re: Analyze sched_switch ftrace data with vcd viewer
Date: Fri, 12 Jun 2009 16:29:57 +0200
Message-ID: <4A326665.3040606@home.nl>
References: <4A281971.1040406@home.nl> <49b7c2350906112312o1ca2aefeq658e6e645021c63f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq1.tb.mail.iss.as9143.net ([212.54.42.164]:51232 "EHLO
	smtpq1.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777AbZFLO3z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Jun 2009 10:29:55 -0400
In-Reply-To: <49b7c2350906112312o1ca2aefeq658e6e645021c63f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tried your vcd file and I can view it with no problems. Did you select 
all signals and then press the insert button in gtkwave?
I run fedora 10 with gtkwave version 'GTKWave Analyzer v3.1.13 
(w)1999-2008 BSI'.

    Herman.


GeunSik Lim wrote:
> On Fri, Jun 5, 2009 at 3:58 AM, Herman ten
> Brugge<hermantenbrugge@home.nl> wrote:
>   
>> I have written some code to convert the ascii sched_switch output to
>> vcd format (value change data). Now it is possible to view the context
>> switches in a vcd viewer. I personally use gtkwave because it is free
>> and is present in the fedora repository.
>> To use this program first make a ftrace file with something like:
>>     
>
>
> Hi Herman ten Brugge,
>
> Thansk you for sharing your code to visualize  sched_switch ftrace data
> with vcd viewer like GTKWave.
>
> This is my H/W requirements.
> * core: Core2 Quad Q9300
> * Memory: DDR3G
> * Kernel: 2.6.29-3.fc10.i686.smp kernel
>
> I tested in my fedora 9 distribution with below methods.
> But I can not show normal result using "#> gtkware trace.vcd" command.
> * screenshot : http://blogfiles5.naver.net/data43/2009/6/12/228/gtkwave-vcd-20090609.1503-invain.png
>
>
> It seems that you have to update your code for stablization and
> functions continually.
>
>
> F-Geunsik#> wget http://www.osadl.org/uploads/media/sched_switch-0.1.tgz
> F-Geunsik#> tar -zxvf sched_switch-0.1.tgz
> F-Geunsik#> cd sched_switch-0.1
> F-Geunsik#> make
> F-Geunsik#> cp ./sched_switch /usr/bin/
> F-Geunsik#> cd /syskerneldebug/tracing/
> F-Geunsik#> echo sched_switch >current_tracer
> F-Geunsik#> echo 1 >tracing_enable
> F-Geunsik#> chrt -f 20 sleep 5
> F-Geunsik#> cyclictest -t 5 -p 99 -d 60 -i 1000
> F-Geunsik#> echo 0 >tracing_enable
> F-Geunsik#> cat trace >/tmp/trace.txt
> F-Geunsik#> /usr/bin/sched_switch /tmp/trace.txt /tmp/trace.vcd
> F-Geunsik#> yum install gtkwave
> F-Geunsik#> gtkwave /tmp/trace.vcd
>
>
>
>
>   

