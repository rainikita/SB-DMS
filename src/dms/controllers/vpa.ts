import { Controller, Get, Param } from '@nestjs/common';
import { VpasService } from '../services/getVpas.services'; 

@Controller('vpas')
export class VpasController { 
  constructor(private readonly vpasService: VpasService) {} 

  @Get() // GET /vpas
  async getVpas() {
    return this.vpasService.getVpas(); 
  }

  // @Get(':id') // GET /vpas
  // async getVpaById(@Param('id')id: string) {
  //   return this.vpasService.getVpas(); // Call the service method to get VPAs
  // }
}
