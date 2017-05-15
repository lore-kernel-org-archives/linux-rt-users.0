From: Eric Nelson <eric@nelint.com>
Subject: Re: Question regarding RT patches for ARM
Date: Mon, 15 May 2017 07:12:55 -0700
Message-ID: <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com>
 <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Fawad Lateef <fawadlateef@gmail.com>,
        GuJiangfei <qiledexin@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Fawad,

> 发自网易邮箱大师
> On 05/15/2017 20:44, Fawad Lateef wrote:
>
> Hi All,
>
> I am working on custom i.MX6 quad hardware and using RT patches for
> almost latest stable kernel 4.9 and facing some weird system stall OR
> 'unhandled page fault - exceptions'.
>

I'm not sure about the unhandled page fault, but the stalls may be
because of the SDMA driver.

See this patch in the Freescale/NXP community for kernel 4.1:
https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/linux/linux-fslc-imx-rt/0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.patch

Regards,


Eric
