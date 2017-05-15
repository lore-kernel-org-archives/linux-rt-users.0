From: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Question regarding RT patches for ARM
Date: Mon, 15 May 2017 16:20:13 +0200
Message-ID: <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com> <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
 <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Eric Nelson <eric@nelint.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Eric,


On 15 May 2017 at 16:12, Eric Nelson <eric@nelint.com> wrote:
> Hi Fawad,
>
>> =E5=8F=91=E8=87=AA=E7=BD=91=E6=98=93=E9=82=AE=E7=AE=B1=E5=A4=A7=E5=B8=88
>> On 05/15/2017 20:44, Fawad Lateef wrote:
>>
>> Hi All,
>>
>> I am working on custom i.MX6 quad hardware and using RT patches for
>> almost latest stable kernel 4.9 and facing some weird system stall OR
>> 'unhandled page fault - exceptions'.
>>
>
> I'm not sure about the unhandled page fault, but the stalls may be
> because of the SDMA driver.
>
> See this patch in the Freescale/NXP community for kernel 4.1:
> https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/li=
nux/linux-fslc-imx-rt/0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.pa=
tch
>

Thanks for the patch link. I will give it a try.

> Regards,
>
>
> Eric

Regards,

Fawad Lateef
