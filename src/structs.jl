abstract type AbstractVariableType end
######################## 变量类型 ########################################
struct VelocityType <: AbstractVariableType
    unit
    low
    up
    defautvalue
    function VelocityType()
        new("m/s",1.0, 5.0, 2.0)        
    end    
end
velocitytype=VelocityType()

# 做一个宏@variabletype
# @variabletype("velocity",unit, low, up, default)产生一个类型和一个类型的实例

# macro variabletype(expr)

#     struct typename
#     end
#     instancense=typename()    
# end
"""
MetaPSE_VARTYPE_STRING记录变量类型表
"""
const MetaPSE_VARTYPE_STRING = Dict(
    "velocitytype" => velocitytype,
)

################################################################


###################### 变量 ###################################
struct Variable{T}
    variabletype::T
    name::Symbol
    #还有哪些字段是必须的？
    function Variable{T}(variabletype,name) where {T<:AbstractVariableType}
        new{T}(variabletype,name)
    end        
end

abcd=Variable(velocitytype,:abcd)

abd=Variable(VelocityType(),:abd)

Variable(variabletype,name) = Variable{typeof(variabletype)}(variabletype,name)

#变量的结构体重写，补充足够的字段

struct Variable2{T}
    """
    变量的类型
    """
    variabletype::T #既已记录变量的类型，那单位、低限、高限等字段就不用了
    """
    变量的名字
    """
    name::Symbol

    #####################既已记录变量的类型，那单位、低限、高限等字段就不用了
    # """
    # # 变量的单位
    # # """
    # unit::String
    # """
    # 变量的最小值
    # """
    # lowerboundry::Float64
    # """
    # 变量的最大值
    # """
    # upperboundry::Float64
    # """
    # 变量的默认值
    # """
    # defaultvalue::Float64

    initialgues::Float64
    #constraint要不要？
    #mktvarsym
    function Variable{T}(variabletype,name) where {T<:AbstractVariableType}
        new{T}(variabletype,name)
    end        
end

Variable(variabletype,name) where {T} = Variable{typeof(variabletype)}(variabletype,name)

Variable(velocity,:v)

# 做个宏 @variable产生一个类型的变量和实例

# @variable(type,name)产生一个类型的变量和实例

#abc=PSEVariable(:abc,PSEUnits.kilomole_per_cubic_metre,1.0, 0.0, 5.0, 2.0)

# 完善这些函数，使得能够返回这些值
getunit(var::Variable{T}) where {T} = 1.0 #var.unit
getlowboundry(var::Variable{T}) where {T} = 1.0 # var.lowerboundry